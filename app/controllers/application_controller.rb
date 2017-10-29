class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notifications, if: :signed_in?
  before_filter :set_search
  def set_search
    #@search = Article.search(params[:q])
    @search = Up.ransack(params[:q]) #ransackメソッド推奨
    @serch_articles = @search.result
  end





  def current_notifications
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end



  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected


    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end


end
