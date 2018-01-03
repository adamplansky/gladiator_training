class MembershipsController < ApplicationController
  layout 'gt'
  before_action :logged_in_admin

  def all_members
    @users = User.all.order(:surname)
  end

  def member
    @users = User.where(is_member: true).order(:surname)
  end

  def notmember
    @users =  User.where(is_member: false).order(:surname).select{|k| k.last_training > (DateTime.now-6.months)}
  end

  def others
    @users = User.all.order(:surname)
  end
end
