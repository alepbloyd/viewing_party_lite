class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to root_path
    elsif params[:email].empty? || params[:password].empty?
      flash[:error] = "Error: please fill in all fields"
      render :new
    else
      flash[:error] = "Error: login failed"
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

end