class UsersController < ApplicationController 

    def show 
        @user = User.find(params[:id])
    end

    def new

    end

    def create
        if user_params[:first_name] == "" || user_params[:last_name] == ""
            redirect_to "/register", notice: "Error: Please complete all fields"
        elsif user_params[:email].include?("@") == false
            redirect_to "/register", notice: "Error: Invalid email address"
        elsif User.exists?(email: user_params[:email].downcase)
            redirect_to "/register", notice: "Error: Email address is taken"
        else
            user = User.create(user_params)
            redirect_to "/users/#{user.id}", notice: "User #{user.email} successfully created!"
        end
    end

    def search 
        redirect_to "/users/#{params[:user_id]}/movies/?=#{params[:search]}"
    end 

    def top_movies
        redirect_to "/users/#{params[:user_id]}/movies/?=top%20rated"
    end 

    def movies 
    end 

    private
    def user_params
        params.permit(:first_name,:last_name,:email)
    end

end 