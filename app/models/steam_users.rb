class SteamUsers

  require 'open-uri'
  require 'steam-condenser'

  attr_accessor :players
  attr_accessor :ranks
  attr_accessor :online_staff
  attr_accessor :converter
  attr_accessor :rank_converter
  attr_accessor :data

  def initialize
    @data = {}
    @rank_converter = {'user' => 0, 'trial-helper' => 1, 'helper' => 2, 'mod' => 3, 'admin' => 4, 'co-owner' => 5, 'superadmin' => 6}
    @converter = {0 => 'User', 1 => 'Trial Helper', 2 => 'Helper', 3 => 'Moderator', 4 => 'Admin', 5 => 'Co-Owner', 6 => 'Owner'}
    load_ranks
    load_server
    load_online_staff
  end

  private
  def load_online_staff
    @online_staff = []
    @data.each do |user, data|
      @players.each do |name, player|
        if player.first.steam_id == data['id']
          online_staff.push data['id']
        end
      end
    end
  end

  def load_server
    @players = Rails.cache.fetch("server", :expires_in => 1.minutes) {
      Rails.logger.info "[#{Time.now.strftime('%F %T')}] Refreshing players cache"
      players = {}
      server = SourceServer.new(Settings.rcon.host, Settings.rcon.port)
      server.rcon_auth(Settings.rcon.password)
      server.players.each do |player|
        name = player[0]
        players[player[1].name] = []
        players[player[1].name].push(player[1])
      end
      players
    }
  end

  def load_ranks
    @ranks = Rails.cache.fetch('ranksfile', :expires_in => 1.second) {
      Rails.logger.info "[#{Time.now.strftime('%F %T')}] Refreshing ranks cache"
      users_file = '/home/gmod/gmod/garrysmod/data/ulib/users.txt'
      lines = []
      ranks = {}
      if not File.exist?(users_file) or not File.readable?(users_file)
        open('https://www.zack6849.com/users.txt') {
            |f| lines = f.read.to_s.split(/\n/)
        }
      else
        f = File.open(users_file, 'r')
        lines = f.read.to_s.split(/\n/)
      end

      found = false
      inside = false
      user = nil
      group = nil
      lines.each do |line|
        umatch = /"(STEAM.+)"/.match(line)
        if umatch
          user = umatch.captures[0]
          inside = true
        end

        gmatch = /.+group"\s"(.+)"/.match(line)
        if inside and gmatch
          group = gmatch.captures[0]
          found = true
        end

        if line == '}'
          if found
            unless @data[user]
              @data[user] = {}
            end
            @data[user]["id"] = user
            @data[user]["user"] = SteamId.new(user)
            @data[user]["rank"] = @rank_converter[group]
            @data[user]["rank_name"] = group
            if ranks[@rank_converter[group]] == nil
              ranks[@rank_converter[group]] = []
            end
            ranks[@rank_converter[group]].push user
          end
          #reset variables for next user tag.
          inside = false
          found = false
          user = nil
          group = nil
        end
      end
     ranks.sort.reverse
    }
  end
end
