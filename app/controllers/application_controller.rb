class ApplicationController < ActionController::API
  include PokeAuthenticable

  before_action :authenticate_ranger!
  rescue_from JWT::ExpiredSignature, with: :expired_token

  private

  def authenticate_ranger!
    return true if current_ranger

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def current_ranger
    @current_ranger ||= Ranger.find(decode(request.authorization.split('Bearer ').second).first['id'])
  end

  def expired_token
    render json: { message: 'Token has expired. Please log in' }, status: :unauthorized
  end

  #  2f. If all of the above are valid send back a payload including some way for users to
  # identify themselves for subsequent requests. That way to identify users should be
  # invalid after 20 minutes and the user must login again to continue communication
  # with the server.
  def encode(payload)
    payload[:exp] = 20.minutes.from_now.to_i

    JWT.encode(payload, POKEY)
  end

  def decode(token)
    JWT.decode(token, POKEY)
  end
end
