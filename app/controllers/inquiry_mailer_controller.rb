class InquiryMailerController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end

  def done
    @inquiry = Inquiry.new(inquiry_params)
    if params[:back]
      render :action => 'new'
    else
      if (InquiryMailer.to_admin_mail(@inquiry).deliver) && (InquiryMailer.to_user_mail(@inquiry).deliver)
        @inquiry.save
        render :action => 'done'
      end
    end
  end 

  def inquiry_params
    params.require(:inquiry).permit(:email,:name,:subject,:message)
  end

end
