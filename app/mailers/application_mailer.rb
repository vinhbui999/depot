# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin1@example.com'
  layout 'mailer'
end
