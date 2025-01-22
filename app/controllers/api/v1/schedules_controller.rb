class Api::V1::SchedulesController < ApplicationController

  def show 
    schedule = Schedule.find_by(user_id: params[:user_id])
    if schedule 
      render json: ScheduleSerializer.new(schedule).serializable_hash.to_json
    else
      render json: { error: "Schedule not found" }, status: :not_found
    end
  end

  def update
    schedule = Schedule.find_by(user_id: params[:user_id])
    show = Show.find_by(id: params[:show_id])

    if schedule && show
      if params[:action_type] == 'add'
        if schedule.shows.count < 8
          schedule.shows << show unless schedule.shows.include?(show)
          render json: ScheduleSerializer.new(schedule).serializable_hash.to_json, status: :ok
        else
          render json: { error: 'Schedule cannot have more than 8 shows' }, status: :unprocessable_entity
        end
      elsif params[:action_type] == 'remove'
        schedule.shows.delete(show)
        render json: ScheduleSerializer.new(schedule).serializable_hash.to_json, status: :ok
      else
        render json: { error: 'Invalid action type' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Schedule or Show not found' }, status: :not_found
    end
  end
end
