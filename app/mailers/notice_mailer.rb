class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_contact.subject
  #
  def sendmail_contact(contact)
    @contact = contact


    #mail to: @contact.email
    mail to: @contact.email,
    subject: '問い合わせを送りました'
  end
end
