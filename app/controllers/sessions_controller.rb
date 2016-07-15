class SessionsController < ApplicationController

  def create
    email = params[:email].strip.downcase
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password].strip)
      reset_session
      session[:user_id] = user.id
      redirect_to root_url, notice: "Welcome back, #{user.name}"
    else
      redirect_to login_url, notice: "Invalid email or password.  Please try again."
    end

  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Good day!"
  end

end
