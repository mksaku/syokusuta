class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: @current_user.id, up_id: params[:up_id])
    @like.save
    redirect_to("/ups/#{params[:up_id]}")
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, up_id: params[:up_id])
    @like.destroy
    redirect_to("/ups/#{params[:up_id]}")
  end
end
