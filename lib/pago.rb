# frozen_string_literal: true

require 'ostruct'

# Fake payment processor
class Pago
  def self.make_payment(order_id:, payment_method:, payment_details:)
    case payment_method
    when :check
      Rails.logger.info "Processing check: #{payment_details.fetch(:routing_number)}/#{payment_details.fetch(:account_number)}"
    when :credit_card
      Rails.logger.info "Processing credit_card: #{payment_details.fetch(:credit_card_number)}/#{payment_details.fetch(:expiration_month)}/#{payment_details.fetch(:expiration_year)}"
    when :purchase_order
      Rails.logger.info "Processing purchase order: #{payment_details.fetch(:purchase_order_number)}"
    else
      raise "Unknown payment_method #{payment_method}"
    end

    sleep 3 unless Rails.env.test?
    Rails.logger.info 'Done Processing Payment'
    OpenStruct.new(succeeded?: true)
  end
end
