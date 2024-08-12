require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "receive mail" do
    receive_inbound_email_from_mail(
      from: "khoa@somewhere.com",
      to: "support@example.com",
      subject: "Need help",
      body: "I can't figure out how to check out"
    )

    support_request = SupportRequest.last
    assert_equal 'khoa@somewhere.com', support_request.email
    assert_equal 'Need help', support_request.subject
    assert_equal 'I can\'t figure out how to check out', support_request.body

    assert_nil support_request.order
  end

  test "create a SupportRequest with most recent associated Order" do
    recent_order = orders(:one)
    older_order = orders(:another_one)
    non_customer = orders(:other_customer)
    receive_inbound_email_from_mail(
      from: recent_order.email,
      to: 'support@example.com',
      subject: 'Need help',
      body: 'I can\'t figure out how to check out'
    )

    support_requests = SupportRequest.last
    assert_equal recent_order.email, support_requests.email
    assert_equal 'Need help', support_requests.subject
    assert_equal 'I can\'t figure out how to check out', support_requests.body

    assert_equal recent_order, support_requests.order
  end
end
