class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@nblist.ru'
  # default from: ENV["MAILJET_SENDER"]
  layout 'mailer'
end
