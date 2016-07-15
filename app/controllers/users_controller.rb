class UsersController < ApplicationController

  before_action :require_login, :only => [:edit, :update, :destroy, :index]
  before_action :find_user, :only => [:edit, :update, :destroy]

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def index
    @users = index_with_search(User, "name")
  end

  def new
    @user = User.new
  end

  def create
    name = params[:user][:name].strip
    email = params[:user][:email].strip
    @user = User.new(name: name, email: email)
    @user.password = params[:user][:password]
    @user.admin = false #all users are not admins by default when they sign up. db admin can change this
    @user.password_confirmation = params[:user][:password_confirmation] #has_secure_password automatically uses this

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thanks for signing up, #{@user.name}"
    else
      render :new
    end
  end

  def update
    @user.update(params.require(:user).permit(:name, :email, :password, :admin))
    redirect_to users_path
  end

  def account_edit
    @user = User.find_by_id(current_user.id)
  end

  def account_update
    @user = User.find_by_id(current_user.id)
    @user.update(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    redirect_to root_path
  end

end
