class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :require_login

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) #||= means keep @user as is if it's well defined, if not, assign the stuff on the right to it.
  end

  def require_login
    if !logged_in?
      redirect_to login_path
    end
  end

  def page_size
    return 50
  end

  def max_dropdown_count
    return 200
  end

  def get_all_users
    return User.all.limit(max_dropdown_count).order("name")
  end

  def index_with_search(model, field)
    if params["search"].present?
      if Rails.env.development?
        return model.page(params[:page]).per(page_size).where("#{field} LIKE ?", "%#{params['search']}%").order(field)
      else
        return model.page(params[:page]).per(page_size).where("#{field} ILIKE ?", "%#{params['search']}%").order(field)
      end
    else
      return model.all.page(params[:page]).per(page_size).order(field)
    end
  end

end
