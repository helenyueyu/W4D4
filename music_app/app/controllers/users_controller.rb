class UsersController < ApplicationController
    def new 
        @user = User.new 
    end

    def show 
        @user = User.find(params[:id])
        render :show 
    end

    def create 
        user = User.new(user_params) # going to generate a new instance of a user 

        if user.save # saves the user to the database 
            login(user)
            redirect_to user_url(user)
        else
            flash.now[:errors] = user.errors.full_messages 
            render :new 
        end
    end

    def user_params 
        params.require(:user)
end
