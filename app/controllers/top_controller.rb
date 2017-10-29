class TopController < ApplicationController
  def index
    @ids = Like.group(:up_id).order('count(up_id) DESC').limit(5).pluck(:up_id)
    @find = Up.find(@ids)
    @ranks = @ids.collect {|id| @find.detect {|x| x.id == id.to_i}}

  end
end
