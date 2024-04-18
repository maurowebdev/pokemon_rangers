# frozen_string_literal: true

class IncidentsController < ApplicationController
  include Pagy::Backend
  before_action :set_incident, only: %i[ show update destroy ]
  # MUST HAVE 4. Read requests must support pagination
  after_action { pagy_headers_merge(@pagy) if @pagy }

  # 3b. Users should be able to read all public elements in the table/collection.\
  # 3c. Users should be able to read all elements created by themselves.
  def index
    @pagy, @incidents = pagy(Incident.where(ranger_id: current_ranger.id).or(Incident.where(public_incident: true)))

    render json: @incidents, include: { ranger: {only: Ranger::PUBLIC_FIELDS } } , root: true, except: %i[ranger_id public updated_at]
  end

  # 3c. Users should be able to read all elements created by themselves.
  def show
    render json: @incident, include: { ranger: {only: Ranger::PUBLIC_FIELDS } } , root: true, except: %i[ranger_id public updated_at]
  end

  def create
    @incident = current_ranger.incidents.new(incident_params)

    if @incident.save
      render json: @incident, status: :created, location: @incident, root: true, except: %i[ranger_id public updated_at]
    else
      render json: @incident.errors, status: :unprocessable_entity
    end
  end

  # 3d. Users should be able to edit at least one field in one of their private items.
  def update
    if @incident.update(incident_params)
      render json: @incident, root: true, except: %i[ranger_id public updated_at]
    else
      render json: @incident.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @incident.destroy!
  end

  private
    def set_incident
      @incident = current_ranger.incidents.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:location, :occurrence_date, :description, :public_incident)
    end
end
