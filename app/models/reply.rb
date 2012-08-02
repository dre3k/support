# == Schema Information
#
# Table name: replies
#
#  id             :integer          not null, primary key
#  replier_id     :integer
#  owner_from_id  :integer
#  owner_to_id    :integer
#  status_from_id :integer
#  status_to_id   :integer
#  message        :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reply < ActiveRecord::Base
  attr_accessible \
    :replier_id,
    :owner_from_id,  :owner_to_id,
    :status_from_id, :status_to_id,
    :message,
    :as => :member
  attr_accessible \
    :replier_id,
    :status_from_id, :status_to_id,
    :message,
    :as => :customer

  validates_presence_of :message

  belongs_to :status_from, :class_name => 'TicketStatus'
  belongs_to :status_to,   :class_name => 'TicketStatus'
  belongs_to :owner_from,  :class_name => 'Member'
  belongs_to :owner_to,    :class_name => 'Member'

  has_one :history
  has_one :ticket, :through => :history

  def replier_name
    @replier ||= \
      if replier_id
        Member.find_by_id(replier_id).name
      else
        ticket.name
      end
  end
end
