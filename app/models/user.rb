# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  password_digest :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  class Error < StandardError
  end

  after_destroy :ensure_an_admin_remains
  enum role: { user: 'user', admin: 'admin' }
  validates :name, uniqueness: true
  validates :role, presence: true

  private

  def ensure_an_admin_remains
    return unless User.where(role: :admin).count.zero?

    raise Error, "Can't delete last admin user!"
  end
end
