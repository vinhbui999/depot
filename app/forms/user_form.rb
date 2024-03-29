# frozen_string_literal: true

class UserForm
  include ActiveModel::Model

  validate :user_is_valid
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z\d-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :name, :password, :password_confirmation, presence: true
  attr_accessor :name, :password, :password_confirmation, :user_id, :current_user, :email, :old_password

  def initialize(params = {})
    if params[:user_id].nil?
      @user = User.new(params)
    else
      begin
        @user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        @user = nil
      else
        @user_id = @user.id
        @name = @user.name
        @email = @user.email
        @current_user = @user
      end
    end
    super(params)
  end

  def submit
    return false if invalid?(:create)

    @user.email = @user.email.downcase
    @user.save
    @user_id = @user.id
    @current_user = @user
  end

  def update(params)
    update_process(params)
    return true if update_form

    false
  end

  def user_is_valid(context = nil)
    return unless @user.invalid?(context)

    @user.errors.each do |attribute, messages|
      errors.add(attribute, messages)
    end
  end

  def update_form
    @user.name = @name
    @user.password = @password
    @user.password_confirmation = @password_confirmation
    return false if invalid?

    @user.save
    @current_user = @user
  end

  def update_process(params)
    @name = params[:name]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end
end
