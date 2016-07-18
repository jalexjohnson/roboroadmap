class BiddersController < ApplicationController

  before_action :require_login
  before_action :find_bidder, :only => [:show, :edit, :update, :destroy]
  before_action :find_project

  def find_bidder
    @bidder = Bidder.find_by_id(params[:id])
  end

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def edit
    require_owner(@project)
    @users = get_all_users
  end

  def update
    require_owner(@project)
    @bidder.update(params.require(:bidder).permit(:allowance))
    redirect_to project_path(@project)
  end

  def create
    require_owner(@project)
    Bidder.create(user_id: params[:user_id], project_id: params[:project_id], allowance: params[:allowance])
    redirect_to project_path(params[:project_id])
  end

  def destroy
    require_owner(@project)
    @bidder.destroy
    redirect_to project_path(params[:project_id]), notice: "Bidder deleted."
  end

end
