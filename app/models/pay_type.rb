# == Schema Information
#
# Table name: pay_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PayType < ApplicationRecord
  has_many :orders
  validates :name, presence: true, uniqueness: true
end
