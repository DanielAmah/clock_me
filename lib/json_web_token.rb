class JsonWebToken
  JWT_SECRET = ENV["JWT_SECRET"]
  class << self
    def encode(payload, exp = 24.hours.from_now)
      # set token expiration time 
      payload[:exp] = exp.to_i
      
       # this encodes the user data(payload) with our secret key
      token = JWT.encode(payload, JWT_SECRET)
      { token:token, exp: exp.to_i }
    end

    def decode(token)
      #decodes the token to get user data (payload)
      body = JWT.decode(token, JWT_SECRET)[0]
      HashWithIndifferentAccess.new body

  
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message
    rescue JWT::DecodeError, JWT::VerificationError => e
      raise ExceptionHandler::DecodeError, e.message
    end
  end
end