class History < ActiveRecord::Base
  attr_accessible :ticket_id, :reply_id

  validates_presence_of :ticket_id, :reply_id
end

# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  ticket_id  :integer          not null
#  reply_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

