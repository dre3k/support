class ApplicationController < ActionController::Base
  protect_from_forgery

  expose(:current_member) { Member.find(session[:member_id]) if session[:member_id] }

  private

  def authorize
    redirect_to login_url, aler: 'Not authorized' if current_member.nil?
  end
end
