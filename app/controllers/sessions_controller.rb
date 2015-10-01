class SessionsController < ApplicationController
  def new
    
  end
  
  def create 
    user = User.find_by(email: params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
         remember user
         redirect_to reservations_path
     else
       flash[:error] = 'Invalid email/password combination' # Not quite right!
       render 'new'
     end
  end
  
  def destroy 
    log_out if logged_in?
    redirect_to unsigned_index_path
  end
  
end
