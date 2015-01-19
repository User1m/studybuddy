class NotificationsMailer < ActionMailer::Base
  default :from => "noreply@studybuddy.dev"
  default :to => "mbembac@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "[studybuddy.tld] #{message.subject}")
  end

end
