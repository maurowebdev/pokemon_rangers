class RangersController < ApplicationController
  before_action :set_ranger, only: :update

  def create
    @ranger = Ranger.new(ranger_params)

    if @ranger.save
      render json: @ranger, status: :created, except: [:password_digest, :updated_at]
    else
      render json: @ranger.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @ranger.update(ranger_params)
      render json: @ranger
    else
      render json: @ranger.errors.messages, status: :unprocessable_entity
    end
  end

  private
    def set_ranger
      @ranger = Ranger.find(params[:id])
    end

    def ranger_params
      params.require(:ranger).permit(:first_name, :last_name, :email, :password, :identification_number)
    end
end
