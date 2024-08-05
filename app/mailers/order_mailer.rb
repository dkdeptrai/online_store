# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'Khoa Dep Trai <onlinestore@example.com>'
  before_action :set_context
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: 'The Online Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'The Online Store Order Shipped'
  end

  private

  def set_context
    @mailer_context = true
  end
end
