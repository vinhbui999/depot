class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :authorize, only: [:new, :create]
  # GET /users or /users.json
  def index
    @users = User.order(:name)
    logger.debug("USers #{User.order(:name)}")
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
    # @user = User.new(user_params)
    # respond_to do |format|
    #   if @user.save
    #     session[:user_id] = @user.id
    #     format.html { redirect_to users_url, locale: I18n.locale, notice: "User #{@user.name} was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
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
    if user && user.authenticate(params[:user][:old_password])
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      @user.errors.add(:base, "Invalid old password. Please input again")
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # @user = User.find_by(id: session[:user_id])
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
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user_form).permit(:name, :password, :password_confirmation)
  end

end
