class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def login
		user = User.find_by(username: session_params[:username]) || User.find_by(email: session_params[:username])
		if user && user.authenticate(session_params[:password])
      token_data = JsonWebToken.encode(user_id: user.id)
			render json: {
				token_data: token_data,
				is_admin: user.role.status === 'admin',
				user: UserSerializer.new(user).as_json
			}
		else
			render json: { 
				error: 'Verify credentials and try again or signup'
			}, status: :unprocessable_entity
		end
	end

  def session_params
    params.require(:user).permit(:username, :password)
  end
end