class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def login
		@form = SessionForm.new(session_params)

		if @form.authenticate
				render json: {
				token_data: @form.token,
				is_admin: @form.record.role.status === 'admin',
				user: UserSerializer.new(@form.record).as_json
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