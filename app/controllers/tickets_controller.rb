class TicketsController < ApplicationController
  expose(:tickets) { Ticket.scoped }

  expose(:name)    { params[:name]    }
  expose(:email)   { params[:email]   }
  expose(:dep)     { params[:dep]     }
  expose(:subject) { params[:subject] }
  expose(:message) { params[:message] }

  #expose(:ticket) {

  def index
  end

  def new
  end

  def create
    ticket = Ticket.create(name: name, email: email, dep: dep, subject: subject, message: message)
    if ticket.save
      redirect_to root_url(auction), :notice => "Ticket #{ticket.id} created!"
    else
      render :action => "new"
    end
  end
end
