# frozen_string_literal: true

json.extract! pay_type, :id, :name, :created_at, :updated_at
json.url pay_type_url(pay_type, format: :json)
