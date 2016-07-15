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
    @job = Job.new
  end

  def show
    @is_owner = current_user.id == @project.user_id
    @bid = Bid.new
    @bids = @job.bids
  end

  def create
    Job.create(job_params)
    redirect_to project_path(@project)
  end

  def update
    @job.update(job_params)
    redirect_to project_path(@project)
  end

  def job_params
    params.require(:job).permit(:name, :size, :description, :link)
  end

  def destroy
    @job.destroy
    redirect_to project_path(params[:project_id]), notice: "Job deleted."
  end

end
