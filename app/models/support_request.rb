# frozen_string_literal: true

# == Schema Information
#
# Table name: support_requests
#
#  id                                               :bigint           not null, primary key
#  body(Body of the support request)                :text
#  email(Email of the submitter)                    :string
#  subject(Subject of the support request)          :string
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#  order_id(Their most recent order, if applicable) :bigint
#
# Indexes
#
#  index_support_requests_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class SupportRequest < ApplicationRecord
  belongs_to :order, optional: true

  has_rich_text :response
end
