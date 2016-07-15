class BiddersController < ApplicationController

  before_action :require_login
  before_action :find_bidder, :only => [:show, :edit, :update, :destroy]
  before_action :find_project, :only => [:show, :edit, :update, :destroy, :new]

  def find_bidder
    @bidder = Bidder.find_by_id(params[:id])
  end

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def edit
    @users = get_all_users
  end

  def update
    @bidder.update(params.require(:bidder).permit(:allowance))
    redirect_to project_path(@project)
  end

  def create
    Bidder.create(user_id: params[:user_id], project_id: params[:project_id], allowance: params[:allowance])
    redirect_to project_path(params[:project_id])
  end

  def destroy
    @bidder.destroy
    redirect_to project_path(params[:project_id]), notice: "Bidder deleted."
  end

end
