# frozen_string_literal: true

require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end
  test 'check dynamic fields' do
    visit store_index_path

    click_on 'Add to Cart', match: :first
    click_on 'Check Out'

    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Purchase order number'

    select 'Check', from: 'Pay type'

    assert has_field? 'Routing number'
    assert has_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Purchase order number'

    select 'Credit card', from: 'Pay type'

    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_field? 'Credit card number'
    assert has_field? 'Expiration date'
    assert has_no_field? 'Purchase order number'

    select 'Purchase order', from: 'Pay type'

    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_field? 'Purchase order number'
  end

  test 'check order and delivery' do
    assert_difference 'Order.count', 1 do
      visit store_index_path
      click_on 'Add to Cart', match: :first
      click_on 'Check Out'

      fill_in 'Name', with: 'Dave Joe'
      fill_in 'Address', with: '123 Main Street'
      fill_in 'Email', with: 'dave@example.com'

      select 'Check', from: 'Pay type'
      fill_in 'Routing number', with: '123456'
      fill_in 'Account number', with: '987654'

      click_button 'Place Order'
      assert_text 'Order was successfully created. Thank you for your order.'

      perform_enqueued_jobs
      perform_enqueued_jobs
      assert_performed_jobs 2
    end

    order = Order.last
    assert_equal 'Dave Joe', order.name
    assert_equal '123 Main Street', order.address
    assert_equal 'dave@example.com', order.email
    assert_equal 'Check', order.pay_type.name
    assert_equal '123456', order.routing_number
    assert_equal '987654', order.account_number
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@example.com'], mail.to
    assert_equal 'Khoa Dep Trai <onlinestore@example.com>', mail[:from].value
    assert_equal 'The Online Store Order Confirmation', mail.subject
  end

  test 'notify when shipped' do
    visit order_path(@order)

    click_on 'Edit this order', match: :first

    fill_in 'Ship date', with: Time.zone.today

    click_on 'Edit Order'

    assert_text 'Order was successfully updated.'

    perform_enqueued_jobs
    perform_enqueued_jobs
    assert_performed_jobs 2

    order = Order.find(orders(:one).id)
    assert_equal Time.zone.today, order.ship_date

    mail = ActionMailer::Base.deliveries.last
    assert_equal [order.email], mail.to
    assert_equal 'Khoa Dep Trai <onlinestore@example.com>', mail[:from].value
    assert_equal 'The Online Store Order Shipped', mail.subject
  end
end
