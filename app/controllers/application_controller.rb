class ApplicationController < ActionController::Base
  include ExceptionHandler
  before_action :authenticate_request

  protect_from_forgery with: :null_session
end


private

def authenticate_request
  header = request.headers['Authorization'] || request.headers['HTTP_AUTHORIZATION']
  header = header.split(' ').last if header

  @decoded = JsonWebToken.decode(header)
  @current_user = User.find(@decoded[:user_id])
  render json: { error: 'Not Authorized' }, status: 401 unless @current_user
end