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

  belongs_to :owner,  :class_name => 'Member'
  belongs_to :status, :class_name => 'TicketStatus'
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
  has_many :replies, :through => :histories, :include => [:owner_from, :owner_to, :status_from, :status_to]

  scope :unsigned, where(:owner_id => nil)
  scope :open, where('not (status_id in (:canceled_id, :completed_id))',
                     canceled_id: TicketStatus::SYMBOLS[:cancelled],
                     completed_id: TicketStatus::SYMBOLS[:completed])
  scope :onhold, where(:status_id => TicketStatus::SYMBOLS[:onhold])
  scope :closed, where(:status_id => [TicketStatus::SYMBOLS[:cancelled], TicketStatus::SYMBOLS[:completed]])

  def self.search_by_subject(subject)
    where('subject LIKE :subject', subject: "%#{subject}%")
  end

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
   # TODO: rationalize & refactor; sanitize_for_mass_assignment ???
    role = options[:as] || :customer
    reply_attributes = \
      Reply.attr_accessible[role].to_a.delete_if(&:empty?).map(&:to_sym)
    # Sanitize options
    options.select! { |key, val| reply_attributes.include? key }

    update_owner = options[:owner_to_id] and Member.find_by_id(options[:owner_to_id])
    if update_owner
      options[:owner_from_id] = read_attribute(:owner_id)
    end

    staff_status_id = TicketStatus::SYMBOLS[:staff]
    status_id = read_attribute(:status_id)
    update_status = \
      if role == :customer
        (status_id != staff_status_id) && (options[:status_to_id] = staff_status_id)
      else
       options[:status_to_id] && TicketStatus.find_by_id(options[:status_to_id])
      end
    if update_status && (status_id != options[:status_to_id])
      options[:status_from_id] = status_id
    else
      options.delete(:status_to_id)
      options.delete(:status_from_id)
    end

    reply = replies.build(options, :as => role)

    if reply.valid?
      # TODO: transaction?
      replies << reply
      ticket_attributes = {}
      ticket_attributes[:owner_id]  = options[:owner_to_id]  if update_owner
      ticket_attributes[:status_id] = options[:status_to_id] if update_status
      update_attributes!(ticket_attributes, without_protection: true) if ticket_attributes.present?
      return reply
    else
      nil
    end
  end
end
