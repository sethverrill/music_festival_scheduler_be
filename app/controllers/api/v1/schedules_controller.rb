class Api::V1::SchedulesController < ApplicationController

  def show 
    schedule = Schedule.find_by(user_id: params[:user_id])

    if schedule 
      render_schedule(schedule, :ok)
    else
      render_error("Schedule not found", :not_found)
    end
  end

  def update
    schedule = Schedule.find_by(user_id: params[:user_id])
    show = Show.find_by(id: params[:show_id])

    if schedule && show
      service = ScheduleService.new(schedule, show)
      result = case params[:action_type]
              when "add"
                service.add_show
              when "remove"
                service.remove_show
              else
                { error: "Invalid action type", status: :unprocessable_entity }
              end
      if result[:schedule]
        render_schedule(result[:schedule], result[:status])
      else
        render_error(result[:error], result[:status])
      end
    else
      render_error("Schedule or Show not found", :not_found)        
    end
  end

  private

  def render_schedule(schedule, status)
    render json: ScheduleSerializer.new(schedule).serializable_hash.to_json, status: status
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
