# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Member < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :username, :password, :password_confirmation

  validates_presence_of   :name
  validates_presence_of   :username
  validates_uniqueness_of :username
end
