class UploaderController < ApplicationController

  require 'awesome_print'
  require 'fileutils'
  require 'securerandom'

  def get
    render 'upload'
  end

  def upload
    # this code is fucking ugly, yo.
    file = params[:upload]
    if file
      save(file)
    else
      get
    end
  end

  private

    def get_path(file)

    end

    def save(file)
      name = File.basename(file.original_filename)
      extension = File.extname(name)[1..-1]
      #if the file exists already, generate a random name
      while File.exists?(File.join(Settings.uploads.directory, name)) do
        name = SecureRandom.hex.to_s + File.extname(file.original_filename);
      end
      allowed = Settings.uploads.whitelist.split(" ")
      directory = Settings.uploads.directory
      realpath = File.join(directory, name)

      unless File.exists?(File.dirname(realpath))
        FileUtils::mkdir_p(File.dirname(realpath))
      end

      if allowed.include? extension
        File.open(realpath, "wb"){ |f|
            f.write(file.read)
        }

        redirect_to "#{'/uploads/' + name}"
      else
        @error = true
        render 'upload'
      end
    end
end
