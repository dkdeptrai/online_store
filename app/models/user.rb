# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  class Error < StandardError
    
  end

  after_destroy :ensure_an_admin_remains

  validates :name, uniqueness: true

  private

  def ensure_an_admin_remains
    return unless User.count.zero?

    raise Error.new "Can't delete last user"
  end
end
