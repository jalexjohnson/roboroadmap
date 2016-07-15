class ProjectsController < ApplicationController

  before_action :require_login
  before_action :find_project, :only => [:show, :edit, :update, :destroy]
  before_action :all_users, :only => [:show, :new, :edit]

  def find_project
    @project = Project.find_by_id(params[:id])
  end

  def all_users
    @users = get_all_users
  end

  def index
    @projects = index_with_search(Project, "name")
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
