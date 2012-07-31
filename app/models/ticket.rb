class Ticket < ActiveRecord::Base
  belongs_to :owner
  belongs_to :status
  attr_accessible :dep, :subject, :message
  attr_readonly   :dep, :subject, :message

  validates_presence_of :dep, :subject, :message

  has_many :replies, :through => :histories

  after_create do |record|
    update_attribute :no, Ticket.no_from_id(record.id)
    update_attribute :url, Ticket.url_from_id(record.id)
  end

  def self.no_from_id(id)
    # TODO: format ABC-123456
    return id
  end

  def self.url_from_id(id)
    # TODO: rationalize
    Digest::SHA1.hexdigest("#{id}-#{UUID.generate}")
  end
end
#
# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  no         :string(255)
#  dep        :string(255)      not null
#  subject    :string(255)      not null
#  message    :text             not null
#  url        :string(255)
#  owner_id   :integer
#  status_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

