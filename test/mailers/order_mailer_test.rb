# frozen_string_literal: true

require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = orders(:one)
    @order.add_line_items_from_cart(carts(:one))

  end

  test 'received' do
    mail = OrderMailer.received(@order)
    assert_equal 'The Online Store Order Confirmation', mail.subject
    assert_equal ['johndoe@gmail.com'], mail.to
    assert_equal ['onlinestore@example.com'], mail.from
    assert_match(/1 x Valid Product 1/, mail.body.encoded)
  end

  test 'shipped' do
    mail = OrderMailer.shipped(@order)
    Rails.logger.debug "Order: #{@order.inspect}"
    Rails.logger.debug "Email body: #{mail.body.encoded}"
    Rails.logger.debug "@order.line_items: #{@order.line_items.inspect}"

    assert_equal 'The Online Store Order Shipped', mail.subject
    assert_equal ['johndoe@gmail.com'], mail.to
    assert_equal ['onlinestore@example.com'], mail.from
    assert_match %r{<td[^>]*>1</td>\s*<td>&times;</td>\s*<td[^>]*>\s*Valid\sProduct\s1\s*</td>}x, mail.body.encoded
  end
end
