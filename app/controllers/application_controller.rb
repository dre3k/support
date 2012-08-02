class ApplicationController < ActionController::Base
  protect_from_forgery

  expose(:current_member) { Member.find(session[:member_id]) if session[:member_id] }

  expose(:all_members_options) do
    Member.select('id, name').map { |item| [item.name, item.id] }
  end

  expose(:all_ticketstatuses_options) do
    TicketStatus.select('id, name').map { |item| [item.name.capitalize, item.id] }
  end

  private

  def authorize
    redirect_to login_url, aler: 'Not authorized' if current_member.nil?
  end
end
