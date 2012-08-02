class HelpController < ApplicationController
  expose(:tickets) { Ticket.scoped }

  def index; end
end
