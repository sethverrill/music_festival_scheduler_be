class Api::V1::ShowsController < ApplicationController
  def index
    shows = Show.all
    render json: ShowSerializer.new(shows).serializable_hash.to_json
  end

  def show
    show = Show.find_by(id: params[:id])
    if show
      render json: ShowSerializer.new(show).serializable_hash.to_json
    else
      render json: { error: "Show not found" }, status: :not_found
    end
  end

  def destroy
    show = Show.find_by(id: params[:id])
    if show
      show.destroy
      head :no_content
    else
      render json: { error: "Show not found" }, status: :not_found
    end
  end
end