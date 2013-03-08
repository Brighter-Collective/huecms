class Admin::UsersController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!

  def index
    @users = User.accessible_by( current_ability )
  end

  def lookup
  	if params[:user_id].to_i != 0
  		@user = User.find( params[:user_id] )
    else
  		@user = ''
  	end
  end

  def update_user
    user = User.find_or_create_by_id( params[:user_id] )

    params[:user].delete("password") if params[:user][:password] == ''

    if user.update_attributes( params[:user] )
      redirect_to '/admin/users'
    else
      flash[:error] = "There was an error."
      return render :json => {:error => 'failure'}
    end
  end

  def remove_user
    user = User.find( params[:user_id] )

    unless user == current_user
      user.destroy
      flash[:success] = "You have successfully removed the user."
      return render :text => 'success'
    else
      flash[:error] = "Can't delete yourself."
      return render :text => "failure"
    end
  end
end
