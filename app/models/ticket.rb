class Ticket < ActiveRecord::Base
  # Number format ABC-123456
  NO_ABC    = ('AAA'..'ZZZ').to_a
  NO_MAXDIG = 6
  NO_MAXNUM = 10 ** NO_MAXDIG

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
    abc_index, number = id.divmod self::NO_MAXNUM # returns [quotient, modulus]
    abc = self::NO_ABC[abc_index]
    # TODO: better handle following exception
    raise "DO SOMETHING WITH TICKET's NUMBERING" unless abc
    "#{abc}-%0#{self::NO_MAXDIG}d" % number
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

