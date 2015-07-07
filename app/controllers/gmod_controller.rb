class GmodController < ApplicationController
  layout nil

  def show
    @steam = SteamUsers.new
    @ranks = @steam.ranks
    @converter = @steam.converter
    #puts @steam.online_staff.inspect
    #puts @steam.players.inspect
    render :'gmod/show', :layout => false
  end
end
