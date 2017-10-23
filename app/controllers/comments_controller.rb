class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @up = @comment.up
    # クライアント要求に応じてフォーマットを変更
  @notification = @comment.notifications.build(user_id: @up.user.id )
    respond_to do |format|
      if @comment.save
        format.html { redirect_to up_path(@up), notice: 'コメントを投稿しました。' }
        format.js { render :index }
        unless @comment.up.user_id == current_user.id
        Pusher.trigger("user_#{@comment.up.user_id}_channel", 'comment_created', {
                 message: 'あなたの投稿にコメントが付きました'
               })

        end
        Pusher.trigger("user_#{@comment.up.user_id}_channel", 'notification_created', {
                unread_counts: Notification.where(user_id: @comment.up.user.id, read: false).count
              })
     else
        format.html { render :new }
      end
    end
  end

    def edit
      @comment = Comment.find(params[:id])
    end


  def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to up_path(@comment.up_id), notice: 'コメントが修正されました'
        else
            render 'edit'
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
