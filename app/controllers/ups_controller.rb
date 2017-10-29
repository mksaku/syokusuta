class UpsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_up, only: [:edit, :update, :destroy, :show]
    before_filter :before_search
    def before_search
          #@search = Article.search(params[:q])
          @search = Up.ransack(params[:q]) #ransackメソッド推奨
          @serch_articles = @search.result
    end

    def search
      #@search = Article.search(params[:q])
      @search = Up.ransack(params[:q]) #ransackメソッド推奨
      @serch_articles = @search.result
    end


    def index

       if params[:back]
         @ups = Up.all
         @up = Up.new(ups_params)
          Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]

          @ids = Like.group(:up_id).order('count(up_id) DESC').pluck(:up_id)
          @find = Up.find(@ids)
          @ranks = @ids.collect {|id| @find.detect {|x| x.id == id.to_i}}








         respond_to do |format|
           format.html
           format.js
         end
      else
        @ups = Up.all
        @up = Up.new
         Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]

                   @ids = Like.group(:up_id).order('count(up_id) DESC').pluck(:up_id)
                   @find = Up.find(@ids)
                   @ranks = @ids.collect {|id| @find.detect {|x| x.id == id.to_i}}
                   @events = @search.result



    end
  end


    def show
      @up_like = Up.find_by(id: params[:id])
    @user = @up_like.user
      #変数@likes_countを定義
     @likes_count = Like.where(up_id: @up_like.id).count

       @comment = @up.comments.build
       @comments = @up.comments
       Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    end

    def new
      if params[:back]
        @ups = Up.all
        @up = Up.new(ups_params)

     else
       @ups = Up.all
       @up = Up.new
     end

    end

    def create
      @ups = Up.all
      @up=Up.new(ups_params)
      @up.user_id = current_user.id
      if @up.save

        redirect_to ups_path, notice: "投稿しました！"
      else
        # 入力フォームを再描画します。
        render 'index'
      end
    end
    def edit

    end


    def update
      if @up.update(ups_params)
        redirect_to ups_path, notice: "ツイートを更新しました！"
      else
        render 'edit'
      end
    end

    def destroy
      # edit, update, destroyで共通コード
      @up.destroy
      redirect_to ups_path, notice: "ツイートを削除しました！"
    end

    def confirm
      @up=Up.new(ups_params)
      render :index if @up.invalid?
    end


    private
      def ups_params
        @ups = Up.all
        params.require(:up).permit(:content,:photo,:title)
      end

      def set_up
        @up = Up.find(params[:id])
      end


end
