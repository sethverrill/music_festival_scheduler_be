class Api::V1::VenuesController < ApplicationController
  def index
    venues = Venue.all
    render json: VenueSerializer.new(venues).serializable_hash.to_json
  end

  def show
    venue = Venue.find_by(id: params[:id])
    if venue
      render json: VenueSerializer.new(venue).serializable_hash.to_json
    else
      render json: { error: "Venue not found" }, status: :not_found
    end
  end
end