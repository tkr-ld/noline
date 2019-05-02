class ApplicationMailer < ActionMailer::Base
  default from: ENV['NOLINE_USER_ADDRESS']
  layout 'mailer'
end
