class ProjectsController < ApplicationController

  before_action :require_login
  before_action :require_admin, :only => [:new, :create, :destroy]
  before_action :find_project, :only => [:show, :edit, :update, :destroy]
  before_action :all_users, :only => [:show, :new, :edit, :create, :update]

  def find_project
    @project = Project.find_by_id(params[:id])
  end

  def all_users
    @users = get_all_users
  end

  def index
    @projects = index_with_search(Project, "name")
    if @projects.count == 1
      redirect_to project_path(@projects.first)
    end
  end

  def show
    @is_owner = current_user.id == @project.user_id
    @bidders = @project.bidders
    @current_user_bidder = @bidders.find_by(user: current_user)
    @bidder = Bidder.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.errors.any?
      render :new
    else
      redirect_to projects_path
    end
  end

  def edit
    current_user.admin || require_owner(@project)
  end

  def update
    current_user.admin || require_owner(@project)
    @project.update(project_params)
    if @project.errors.any?
      render :edit
    else
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:name, :capacity, :auction_end, :user_id)
  end

end
