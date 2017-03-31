class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # puts "#{params[:session][:email]}:#{params[:session][:password]}"
     if user && user.authenticate(params[:session][:password])
        flash[:notice] = "You have been successfully logged in"
        remember user
        #redirect_to reservations_path
        redirect_back_or challenges_path
     else
       flash[:error] = 'Invalid email/password combination' # Not quite right!
       render 'new'
     end
  end

  def destroy
    log_out if logged_in?
    redirect_to :root
  end

end
