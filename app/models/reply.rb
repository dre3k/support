class Reply < ActiveRecord::Base
  attr_accessible :owner_from, :owner_to, :status_from, :status_to, :message

  validates_presence_of :message
end

# == Schema Information
#
# Table name: replies
#
#  id          :integer          not null, primary key
#  owner_from  :integer
#  owner_to    :integer
#  status_from :integer
#  status_to   :integer
#  message     :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

