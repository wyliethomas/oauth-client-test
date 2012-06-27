class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user


  def authenticate_user
     if session[:user_id] && session[:expiry_time]
       user = User.find(session[:user_id])
       if session[:expiry_time] >= 20.minutes.ago 
         session[:expiry_time] = Time.now
       else
         session[:user_id] = nil
         redirect_to root_url
       end
     else
       redirect_to root_url
     end
  end

  private 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
