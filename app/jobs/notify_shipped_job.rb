# frozen_string_literal: true

class NotifyShippedJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.notify_shipped
  end
end
