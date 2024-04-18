class SessionsController < ApplicationController
  skip_before_action :authenticate_ranger!, only: :create

  def create
    credentials = Base64.decode64(request.authorization&.split('Basic ').last)&.split(':')
    @ranger = Ranger.find_by_email(credentials.first)

    if @ranger&.authenticate(credentials.second)
      render json: {
        token: encode(id: @ranger.id),
        exp: 20.minutes.from_now,
        email: @ranger.email
      }, status: :ok
    else
      head :unauthorized
    end
  end
end
