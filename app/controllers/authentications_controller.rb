class AuthenticationsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @authentications = Authentication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authentications }
    end
  end

  def create
    omniauth = request.env["omniauth.auth"]

    if omniauth['provider'] == 'facebook'
      auth = FbGraph::Auth.new(ENV['FB_APP_ID'], ENV['FB_APP_SECRET'])
      auth.exchange_token! omniauth[:credentials][:token]
      omniauth[:credentials][:token] = auth.access_token.access_token
    end

    authentication = Authentication.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    authentication.token = omniauth[:credentials][:token]
    authentication.secret = omniauth[:credentials][:secret]
    if authentication.save and authentication.set_username
      flash[:notice] = "Signed in to #{authentication.provider} successfully."
      redirect_to new_endpoint_path(tab_name: authentication.provider)
    else
      flash[:error] = "Something went wrong creating the authentication."
      redirect_to new_endpoint_path
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    session[@authentication.provider] = nil
    flash[:notice] = "Successfully destroyed authenticaion."
    redirect_to authentications_url
  end

  def omniauth_failure
    redirect_to new_endpoint_path, error: "Please restart the server to use this application."
  end

    

  def debug_fb_token
    app = FbGraph::Application.new(ENV['FB_APP_ID'], :secret => ENV['FB_APP_SECRET'])
    result = app.debug_token auth.access_token
    logger.debug result.to_yaml
  end
end
