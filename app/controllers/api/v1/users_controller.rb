class Api::V1::UsersController < ApplicationController

  def index
    users = User.all 
    render json: UserSerializer.new(users).serializable_hash.to_json
  end

  def show 
    user = User.includes(:schedule).find(params[:id])

    render json: UserSerializer.new(user).serializable_hash, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end