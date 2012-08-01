class TicketsController < ApplicationController

  expose(:name)       { params[:name]       }
  expose(:email)      { params[:email]      }
  expose(:department) { params[:department] }
  expose(:subject)    { params[:subject]    }
  expose(:message)    { params[:message]    }

  expose(:ticket)  { @ticket }
  expose(:tickets) { Ticket.scoped }

  def index
  end

  def new
  end

  def create
    @ticket = Ticket.create(name: name, email: email, department: department, subject: subject, message: message)
    if ticket.save
      redirect_to root_url, :notice => "Ticket #{ticket.no} created! URL is #{ticket.url}"
    else
      render :action => "new"
    end
  end
end
