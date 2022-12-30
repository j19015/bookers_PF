class UserMailer < ApplicationMailer
  def send_mail(user)
    mail(
      #from: 'system@example.com',
      to:   'user.email',
      subject: '主催者からの通知'
    )
  end
end
