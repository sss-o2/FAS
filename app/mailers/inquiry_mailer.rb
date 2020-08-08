class InquiryMailer < ApplicationMailer
  def test_mail(title,message)
    p "#{title}を送りました。"
    @title=title
    @message=message
  end

  def to_admin_mail(inquiry)
    @inquiry = inquiry
    p "#{@inquiry.subject}を送りました。"
    mail(
      from: @inquiry.email,
      to:   ENV['MAIL_ADDRESS'],
      subject: 'お問い合わせ通知'
    )
  end

  def to_user_mail(inquiry)
    @inquiry = inquiry
    p "#{@inquiry.subject}を送りました。"
    mail(
      from: ENV['MAIL_ADDRESS'],
      to:   @inquiry.email,
      subject: '【FAS運営】お問い合わせありがとうございます'
    )do |format|
      format.text
      format.html
    end
  end
end
