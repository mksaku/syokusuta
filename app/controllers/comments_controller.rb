class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @up = @comment.up
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to up_path(@up), notice: 'コメントを投稿しました。' }
         format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end




  def destroy
  @comment = Comment.find(params[:id])
  @comment.destroy
  respond_to do |format|
    format.js { render :index, notice: 'コメントを削除しました。'  }
  end
end


  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:up_id, :content)
    end
end
