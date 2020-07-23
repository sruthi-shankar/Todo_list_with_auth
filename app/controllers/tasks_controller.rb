class TasksController < ApplicationController
    before_action :find_task, only: [:show, :edit, :update, :destroy, :complete_task]
    before_action :authenticate_user!
    before_action :authorize!, only: [:edit, :update, :destroy, :complete_task]
    # show the list of tasks
    def index 
        @tasks = Task.where(user_id: current_user.id).order(created_at: :desc)
    end

    def new
        @task = Task.new # we need an instance of our resource to be used with 'form_with'
    end

    def create
        @task = Task.new(params.require(:task).permit(:title))
        @task.user = current_user
        if @task.save 
            redirect_to task_path(@task)
        else
            redirect_to new_task_path
        end
    end

    def show 

    end

    def destroy
        @task.destroy 
        redirect_to tasks_path
    end

    def edit 
    end

    def update 
        if @task.update(params.require(:task).permit(:title))
            @task.update_attribute(:is_complete, false)
            redirect_to task_path(@task)
        else
            render :edit 
        end
    end

    def complete_task 
        is_complete_val = @task.is_complete ? false : true
        if @task.update_attribute(:is_complete, is_complete_val)
            redirect_to task_path(@task)
        else
            render :show 
        end
       
    end
    
    private

    def find_task 
        @task = Task.find params[:id]
    end

    def authorize!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @task)
    end

end
