# frozen_string_literal: true

class JwtService
  def self.encode(payload)
    JWT.encode(payload, 'fe3c8afbcd459a95aa00f50aeb3a4c117ee057af2134734caf76e51d5bae9eee20ab5c9f9557aebf156864c389ba6f8f229dade7345dac1363980f0920164092', 'HS256')
  end

  def self.decode(token)
    body, = JWT.decode(token, Rails.application.secrets.secret_key_base,
                       true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    nil
  end
end
