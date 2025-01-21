class Api::V1::SchedulesController < ApplicationController

  def show 
    schedule = Schedule.find_by(user_id: params[:user_id])
    if schedule 
      render json: ScheduleSerializer.new(schedule).serializable_hash.to_json
    else
      render json: { error: "Schedule not found" }, status: :not_found
    end
  end
end