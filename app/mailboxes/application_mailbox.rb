class ApplicationMailbox < ActionMailbox::Base
  routing /support@example.com/i => :support
end
