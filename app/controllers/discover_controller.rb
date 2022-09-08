class DiscoverController < ApplicationController
    def show
        if !current_user
            redirect_to root_path
            flash[:error] = "Must be logged in to view dashboard"
        else
            @user = User.find(params[:id])
        end
    end 
end