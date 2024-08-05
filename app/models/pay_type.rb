# frozen_string_literal: true

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
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
