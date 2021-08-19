class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :authorize, only: [:index, :edit, :update, :destroy]
  # GET /users or /users.json
  def index
    @users = User.order(:name)
    #return index by name
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    # @user = User.new
    @form = UserForm.new
    session[:update] = false
  end

  # GET /users/1/edit
  def edit
    session[:update] = true
  end

  # POST /users or /users.json
  def create
    @form = UserForm.new(user_params)
    if @form.submit
      session[:user_id] = @form.user_id
      redirect_to users_url, locale: I18n.locale, notice: "User #{@form.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    user = User.find(session[:user_id])
    if user && user.authenticate(params[:user_form][:old_password])
        if @userForm.update(user_params.merge(id: params[:id]))
          redirect_to users_url, notice: "User #{@userForm.name} was successfully updated."
        else
          logger.debug("Errors #{@userForm.errors.count}")

          render :edit, status: :unprocessable_entity
      end
    else
      @userForm.errors.add(:base, "Invalid old password!!!")
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find_by(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  rescue_from "User::Error" do |exception|
    redirect_to users_url, notice: exception.message
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @userForm = UserForm.new(user_id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user_form).permit(:name, :password, :password_confirmation, :email)
  end
end
