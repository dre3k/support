class TicketStatus < ActiveRecord::Base
  NAMES = [
    'waiting for staff response', 'waiting for customer', 'on hold',
    'cancelled', 'completed'
  ]
  SYMBOLS = { staff: 0, customer: 1, onhold: 2, cancelled: 3, completed: 4 }

  attr_accessible :name
  attr_readonly   :name

  validates_presence_of   :name
  validates_uniqueness_of :name
end

# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

