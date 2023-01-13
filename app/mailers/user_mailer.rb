class UserMailer < ApplicationMailer
  def send_mail(title,content,group_users) #メソッドに対して引数を設定
    @title = title
    @content = content
    mail bcc: group_users.pluck(:email), subject: title
  end
end
