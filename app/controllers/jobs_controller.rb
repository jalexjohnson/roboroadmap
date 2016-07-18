class JobsController < ApplicationController

  before_action :require_login
  before_action :find_job, :only => [:show, :edit, :update, :destroy]
  before_action :find_project

  def find_job
    @job = Job.find_by_id(params[:id])
  end

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def new
    require_owner(@project)
    @job = Job.new
  end

  def show
    @is_owner = current_user.id == @project.user_id
    @current_user_bidder = Bidder.find_by(user: current_user)
    if @current_user_bidder.present? && @project.bidding_open?
      @bid = @current_user_bidder.bids.find_by(job_id: @job.id)
      @bid ||= Bid.new
    end
    @bids = @job.bids
  end

  def create
    require_owner(@project)
    Job.create(job_params)
    redirect_to project_path(@project)
  end

  def edit
    require_owner(@project)
  end

  def update
    require_owner(@project)
    @job.update(job_params)
    redirect_to project_path(@project)
  end

  def job_params
    params.require(:job).permit(:name, :size, :description, :link, :project_id)
  end

  def destroy
    require_owner(@project)
    @job.destroy
    redirect_to project_path(params[:project_id]), notice: "Job deleted."
  end

end
