# frozen_string_literal: true

json.array! @pay_types, partial: 'pay_types/pay_type', as: :pay_type
