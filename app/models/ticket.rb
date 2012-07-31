class Ticket < ActiveRecord::Base
  belongs_to :owner
  belongs_to :status
  attr_accessible :dep, :subject, :message
  attr_readonly   :no, :dep, :subject, :message, :url

  validates_presence_of :dep, :subject, :message
end

# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  no         :string(255)      not null
#  dep        :string(255)      not null
#  subject    :string(255)      not null
#  message    :text             not null
#  url        :string(255)      not null
#  owner_id   :integer
#  status_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

