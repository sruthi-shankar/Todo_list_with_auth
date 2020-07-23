class UsersController < ApplicationController
    def new
        @user=User.new

    end

    def create 
        @user = User.new params.require(:user).permit(:first_name, :last_name, :email, :password, :pass_confirmation)
        if @user.save 
            flash.delete(:warning)
            session[:user_id] = @user.id
            redirect_to tasks_path 
        else 
            flash[:warning] = "Unable to create user"
            render :new 
        end
    end
end
