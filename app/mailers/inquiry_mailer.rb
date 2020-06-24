class InquiryMailer < ApplicationMailer
  def test_mail(title,message)
    p "#{title}を送りました。"
    @title=title
    @message=message
  end

  def send_mail(inquiry)
    @inquiry = inquiry
    p "#{@inquiry.subject}を送りました。"
    mail(
      from: 'o.matsu.youser12@gmail.com',
      to:   'fas.appadm@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
