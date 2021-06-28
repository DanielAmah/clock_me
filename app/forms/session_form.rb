class SessionForm
  include ActiveModel::Model
  attr_accessor :username, :email, :password
  attr_reader :token, :record

  def authenticate
    user = User.find_by(username: self.username) || User.find_by(email: self.username)
    if user && user.authenticate(self.password)
      token_data = JsonWebToken.encode(user_id: user.id)
      @record = user
      @token = token_data
      true
    else
      false
    end
  end
end