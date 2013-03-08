class EndpointsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :xml, :json

  def index
    @endpoints = Endpoint.all
    respond_with(@endpoints)
  end

  def create
    @endpoint = Endpoint.create!(params[:endpoint])
    flash[:success] = "Endpoint created successfully."
    respond_with(@endpoint, :location => edit_endpoint_path(@endpoint))
  end

  def new
    @endpoint = Endpoint.new
    params[:tab_name] = params[:tab_name] || "server"
    respond_with(@endpoint)
  end

  def edit
    @endpoint = Endpoint.find(params[:id])
    respond_with(@endpoint)
  end

  def update
    params[:endpoint].delete(:password) if params[:endpoint][:password].empty?
    @endpoint = Endpoint.find(params[:id])
    if @endpoint.update_attributes(params[:endpoint])
      flash[:success] = "Endpoint updated. #{undo_link}"
    end
    respond_with(@endpoint, :location => edit_endpoint_url)
  end

  def destroy
    endpoint = Endpoint.find(params[:id]).destroy
    flash[:success] = "Endpoint #{endpoint.name} destroyed."
    respond_with(@endpoint)
  end

  def register_social_app

    if params[:provider] == "facebook"
      begin
        app = FbGraph::Application.new(params[:app_id], secret: params[:app_secret])
        result = app.get_access_token
        result.application
        File.open(Rails.root.to_s + "/config/initializers/facebook_app.rb", 'w') do |f| 
           f.write("ENV['FB_APP_ID'] = '#{params[:app_id]}'\n")
           f.write("ENV['FB_APP_SECRET'] = '#{params[:app_secret]}'")
        end
        redirect_to(new_endpoint_path, notice: "Your Facebook app was configured successfully. Please restart the server to use this application.")
      rescue Exception => ex
        logger.debug(ex.inspect)
        redirect_to(new_endpoint_path, error: "Please double check the values provided for the Facebook app.")
      end
    elsif params[:provider] == "twitter"
      begin
        File.open(Rails.root.to_s + "/config/initializers/twitter_app.rb", 'w') do |f| 
           f.write("ENV['TWITTER_CONSUMER_KEY'] = '#{params[:app_id]}'\n")
           f.write("ENV['TWITTER_CONSUMER_SECRET'] = '#{params[:app_secret]}'")
        end
        redirect_to(new_endpoint_path, notice: "Your Twiter app was configured successfully. Please restart the server to use this application.")
      rescue Exception => ex
        logger.debug(ex.inspect)
        redirect_to(new_endpoint_path, error: "Please double check the values provided for the Twitter app.")
      end
    end
  end

  private 

    def undo_link
      view_context.link_to("undo", revert_version_url(@endpoint.versions.scoped.last), :method => :post)
    end
end
