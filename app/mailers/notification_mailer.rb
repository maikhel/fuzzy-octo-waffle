class NotificationMailer < ActionMailer::Base
  default from: ENV['MAILER_FROM'], reply_to: ENV['MAILER_REPLY_TO']

end