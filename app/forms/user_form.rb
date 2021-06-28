class UserForm

  def initialize(user_params)
    super
    @user_params = user_params
  end

  include ActiveModel::Model
  include ActiveRecord::Persistence

  attr_accessor :username, :email, :password, :password_confirmation, :profession, :role
  attr_reader :record

  validates_presence_of :username, :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'requires a valid email format!' } 
  validates :username, length: { minimum: 5, message: "is too short!" }

  validates :password,
            length: { minimum: 6, message: "is too short!" },
            if: -> { new_record? || !password.nil? }

  validate :email_is_unique
  validate :username_is_unique

  def save
    role = Role.find_by(status: 'staff')
    profession = Profession.find_by(name: @user_params[:profession])
    @record = User.new @user_params.except(:profession)
    if @record.valid?
      @record.save
      UserRole.create!(
        user: @record,
        role: role
      )
      UserProfession.create!(
        user: @record,
        profession: profession
      )
      true
    else
      false
    end
  end

  private

  def email_is_unique
    if User.where(email: email).exists?
      errors.add(:email, 'has been taken!')
    end
  end

  def username_is_unique
    if User.where(username: username).exists?
      errors.add(:username, 'has been taken!')
    end
  end
end