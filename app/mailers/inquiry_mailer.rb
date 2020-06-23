class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'o.matsu.youser12@gmail.com',
      to:   'fas.appadm@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
