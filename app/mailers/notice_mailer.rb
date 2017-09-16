class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_insta.subject
  #
  def sendmail_insta
    @photo = photo

    mail to: "to@example.org"
    subject:'投稿されました'
  end
end
