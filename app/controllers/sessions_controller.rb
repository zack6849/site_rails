class SessionsController < ApplicationController

  def new
    @title = 'Login in to continue'
    @user = User.new
  end

  def create
    @user = User.find_by_name(params[:name])
    if @user!= nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @error = 'Invalid username or password!'
      p 'Set error to ' + @error
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back
  end
end
