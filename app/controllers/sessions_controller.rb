class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate params[:password]
            session[:user_id]=user.id
            session[:fav_animal]='wolf'
            flash[:success]='User Logged In'
            redirect_to tasks_path
        else 
            flash[:warning]="Could not Log In"
        end

    end
    def destroy
        session[:user_id] = nil 
        redirect_to tasks_path
    end

end
