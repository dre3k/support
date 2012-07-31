class Reply < ActiveRecord::Base
  attr_accessible \
    :owner_from_id,  :owner_to_id,
    :status_from_id, :status_to_id,
    :message

  validates_presence_of :message
end

# == Schema Information
#
# Table name: replies
#
#  id             :integer          not null, primary key
#  owner_from_id  :integer
#  owner_to_id    :integer
#  status_from_id :integer
#  status_to_id   :integer
#  message        :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
