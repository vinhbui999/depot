class UserForm
    include ActiveModel::Model

    validate :user_is_valid
    validates :name, :password, :password_confirmation, presence: true
    attr_accessor :name, :password, :password_confirmation, :user_id, :current_user

    def initialize(params = {})
        @user = User.new(params)
        super(params)
    end

    def submit
        return false if invalid?
        @user.save
        @user_id = @user.id
        @current_user = @user
    end

    def user_is_valid
        errors.add(:name, 'is existed') if @user.invalid?
    end
  
  end