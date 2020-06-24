class InquiryMailerController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  # def create
  #   @inquiry = Inquiry.new(post_params)

  #   if InquiryMailer.send_mail(@inquiry).deliver
  #     redirect_to new_inquiry_mailer_path,notice: 'メール送信しました'
  #   else
  #     render :new
  #   end
  # end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    # if InquiryMailer.send_mail(@inquiry).deliver
    #   redirect_to new_inquiry_mailer_path,notice: 'メール送信しました'
    # else
    #   render :confirm
    # end
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end

  def done
    # backが押されなかったら送信して、送りましたページ(doneページ)表示するやで、てことはget？
    @inquiry = Inquiry.new(inquiry_params)
    if params[:back]
      render :action => 'new'
    else
      if InquiryMailer.send_mail(@inquiry).deliver
        @inquiry.save
        render :action => 'done'
      end
    end
  end 

  # def contact
  #   @title = params[:title]
  #   @message=params[:message]
  #   InquiryMailer.test_mail(@title,@message).deliver
  #   redirect_to action: :show,notice: 'メール送信しました'
  # end

  def inquiry_params
    params.require(:inquiry).permit(:email,:name,:subject,:message)
  end

end
