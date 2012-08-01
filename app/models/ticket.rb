# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  department :string(255)      not null
#  subject    :string(255)      not null
#  message    :text             not null
#  no         :string(255)
#  url        :string(255)
#  owner_id   :integer
#  status_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ticket < ActiveRecord::Base
  # Number format ABC-123456
  NO_ABC    = ('AAA'..'ZZZ').to_a
  NO_MAXDIG = 6
  NO_MAXNUM = 10 ** NO_MAXDIG
  NO_REGEX  = /[A-Z]{3}-\d{#{NO_MAXDIG}}/

  belongs_to :owner
  belongs_to :status
  attr_accessible :name, :email, :department, :subject, :message
  attr_readonly   :name, :email, :department, :subject, :message

  validates_presence_of :name, :email, :department, :subject, :message

  after_create do |record|
    no =  Ticket.no_from_id(record.id)
    url = Ticket.url_from_no(no)
    attributes = { no: no, url: url, status_id: TicketStatus::SYMBOLS[:staff] }
    update_attributes!(attributes, without_protection: true)
  end

  has_many :histories
  has_many :replies, :through => :histories

  scope :unsigned, where(:owner_id => nil)
  scope :open, where('not (status_id in (:canceled_id, :completed_id))',
                     canceled_id: TicketStatus::SYMBOLS[:cancelled],
                     completed_id: TicketStatus::SYMBOLS[:completed])
  scope :onhold, where(:status_id => TicketStatus::SYMBOLS[:onhold])
  scope :closed, where(:status_id => [TicketStatus::SYMBOLS[:cancelled], TicketStatus::SYMBOLS[:completed]])


  def self.no_from_id(id)
    abc_index, number = id.divmod self::NO_MAXNUM # returns [quotient, modulus]
    abc = self::NO_ABC[abc_index]
    # TODO: better handle following exception
    raise "DO SOMETHING WITH TICKET's NUMBERING" unless abc
    "#{abc}-%0#{self::NO_MAXDIG}d" % number
  end

  def self.url_from_no(no)
    # TODO: rationalize
    Digest::SHA1.hexdigest("#{no}-#{UUID.generate}")
  end

  def add_reply(options)
    # TODO: rationale?
    reply_attributes = \
      Reply.attr_accessible[:default].to_a.delete_if(&:empty?).map(&:to_sym)
    options.select! { |key, val| reply_attributes.include? key }

    update_owner = options[:owner_to_id] and Member.find_by_id(options[:owner_to_id])
    if update_owner
      options[:owner_from_id] = read_attribute(:owner_id)
    end

    update_status = options[:status_to_id] and \
      TicketStatus.find_by_id(options[:status_to_id])
    if update_status
      options[:status_from_id] = read_attribute(:status_id)
    end

    reply = replies.build options

    if reply.valid?
      # TODO: transaction?
      replies << reply
      ticket_attributes = \
        { owner_id: options[:owner_to_id], status_id: options[:status_to_id] }
      update_attributes!(ticket_attributes, without_protection: true)
    end

    return reply
  end
end
