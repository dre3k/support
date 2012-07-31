class Member < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password, :password_confirmation

  validates_uniqueness_of :username
end

# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

