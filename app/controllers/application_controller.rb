class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #redirect to root_url if access denied.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def email_exists
    user = User.where(:email => params[:email])

    if user.count > 0
      return render :text => 'true'
    else
      return render :text => 'false'
    end
  end
end
