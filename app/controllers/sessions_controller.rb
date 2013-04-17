class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    if user.new_record?
      user.save!
      session[:user_id] = user.id
      redirect_to edit_user_path(user), notice: "Signed in!"
    else
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in!"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end