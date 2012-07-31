class SessionsController < ApplicationController
  expose(:username) { params[:username] }
  expose(:password) { params[:password] }

  def new
  end

  def create
    member = Member.find_by_username(username)
    if member && member.authenticate(password)
      session[:member_id] = member.id
      redirect_to tickets_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Username or password is invalid'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'Logged out!'
  end
end
