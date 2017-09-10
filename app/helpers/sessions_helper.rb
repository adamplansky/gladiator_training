module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user

    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to signin_path, notice: "Musíte se přihlásit."
    end
  end

  def logged_in_admin
    unless admin_in?
      store_location
      redirect_to signin_path, notice: "Nemáte dostatečné oprávnění."
    end
  end

  def admin_in?
    return true if !current_user.nil? && current_user.admin == true
    return false
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     session.delete(:return_to)
   end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
