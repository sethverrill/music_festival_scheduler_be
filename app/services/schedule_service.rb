class ScheduleService
  MAX_SHOWS = 8

  def initialize(schedule, show)
    @schedule = schedule 
    @show = show 
  end

  def add_show
    return { error: "Shecdule cannot have more tha #{MAX_SHOWS} shows", status: :unprocessable_entity } if @schedule.shows.count >= MAX_SHOWS

    unless @schedule.shows.include?(@show)
      @schedule.shows << @show
    end

    { schedule: @schedule, status: :ok}
  end

  def remove_show
    if @schedule.shows.include?(@show)
      @schedule.shows.delete(@show)
      { schedule: @schedule, status: :ok}
    else
      { error: "Show not found in schedule", status: :not_found }
    end
  end
end
