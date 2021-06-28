class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @form = UserForm.new(user_params)
    if @form.save
      render json: { 
        data: UserSerializer.new(@form.record).as_json,
        message: 'User created successfully!'}, status: :created
    else 
      render json: {
        errors: @form.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profession)
  end
end