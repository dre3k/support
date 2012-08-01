class TicketsController < ApplicationController
  before_filter :authorize, only: [:index, :show]

  expose(:name)       { params[:name]       }
  expose(:email)      { params[:email]      }
  expose(:department) { params[:department] }
  expose(:subject)    { params[:subject]    }
  expose(:message)    { params[:message]    }

  #expose(:ticket)  { @ticket }

  expose(:id)    { params[:id]    }
  expose(:scope) { params[:scope] }

  expose(:ticket)  do
    if id && (ticket = Ticket.find_by_id(id))
      ticket
    else
      @ticket
    end
  end

  expose(:tickets) do
    case
    when scope && Ticket.respond_to?(scope)
      Ticket.send scope
    else
      Ticket.scoped
    end
  end

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

  def show
  end
end
