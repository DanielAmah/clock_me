class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    role = Role.find_by(status: 'staff')
    profession = Profession.find_by(name: user_params[:profession])

    user = User.new(user_params.except(:profession))
    if user.save
      UserRole.create!(
        user: user,
        role: role
      )
      UserProfession.create!(
        user: user,
        profession: profession
      )
      render json: { 
        data: UserSerializer.new(user).as_json, 
        message: 'User created successfully!'}, status: :created
    else 
      render json: {
        errors: user.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profession)
  end
end