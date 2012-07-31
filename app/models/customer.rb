# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ActiveRecord::Base
  attr_accessible :name, :email

  validates_presence_of   :name
  validates_uniqueness_of :email
  # TODO: validation for email
end
