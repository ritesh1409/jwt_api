module JwtToken
  extend ActiveSupport::Concern

  SECRET_KEY = "611bc595d4d3ae3f7742d21dfa10887e08a1f6c5f34734e0a4aadf57591fc4013e684a8a59e8c64d3b070fcfab45c536880d7924a72232b130bba39dec53babb"

  def encoded(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decoded(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
