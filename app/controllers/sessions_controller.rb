class SessionsController < ApplicationController
  # skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      userForm = UserForm.new(user_id: user.id)
      session[:user_id] = userForm.user_id
      redirect_to users_url, notice: "Login successfully"
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:update] = false
    redirect_to store_index_url, notice: "Logged out"
  end

end
