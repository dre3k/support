class TicketsController < ApplicationController
  expose(:name)       { params[:name]       }
  expose(:email)      { params[:email]      }
  expose(:department) { params[:department] }
  expose(:subject)    { params[:subject]    }
  expose(:message)    { params[:message]    }

  expose(:id)    { params[:id]    }
  expose(:scope) { params[:scope] }

  expose(:ticket)  do
    # TODO: refactor
    if id
      ticket = current_member ? Ticket.find_by_id(id) : Ticket.find_by_url(id)
      if ticket
        ticket
      else
        raise ActionController::RoutingError.new("No route matches [#{request.method}] \"#{request.path}\"")
      end
    else
      @ticket
    end
  end

  expose(:replies) do
    if ticket && (replies = ticket.replies)
      replies
    else
      nil
    end
  end

  expose(:tickets) do
    case
    when scope && Ticket.respond_to?(scope)
      Ticket.send scope
    when subject && (tickets = Ticket.search_by_subject(subject))
      tickets
    else
      Ticket.scoped
    end
  end

  expose(:no) { (no = params[:no]) && (Ticket::NO_REGEX =~ no.upcase!) ? no : nil }
  expose(:subject) { params[:subject] }

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

  def search
    if no && (@ticket = Ticket.find_by_no(no))
      render 'show'
    elsif subject
      render 'index'
    else
      redirect_to tickets_path, :notice => 'Please enter valid ticket reference number or subject'
    end
  end
end
