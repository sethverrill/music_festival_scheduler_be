class Api::V1::UsersController < ApplicationController

  def show 
    user = User.includes(:schedule).find(params[:id])
    puts user.schedule.inspect
    render json: UserSerializer.new(user).serializable_hash, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end