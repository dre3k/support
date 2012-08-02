class HelpController < ApplicationController
  expose(:tickets) { Ticket.scoped }
  expose(:members) { Member.scoped }

  def index; end
end
