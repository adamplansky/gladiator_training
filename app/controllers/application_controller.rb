class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :print_request
  def print_request
    puts '------------------'
    if request.subdomain == 'gladiatorchallenge' || request.domain == 'gladiatorchallenge.cz'
      redirect_to gt_races_path
    end
    puts request.domain
    puts request.path
    puts '------------------'
  end
end
