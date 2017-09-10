class UpsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_up, only: [:edit, :update, :destroy]

    def index

       if params[:back]
         @ups = Up.all
         @up = Up.new(ups_params)

      else
        @ups = Up.all
        @up = Up.new
      end
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
        params.require(:up).permit(:content,:photo)
      end

      def set_up
        @up = Up.find(params[:id])
      end


end
