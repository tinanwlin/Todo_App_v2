class TodosController < ApplicationController
  def index
    if current_user
      @todos = current_user.todos
      render "index.html.erb"
    else
      flash[:alert] = "You must be logged in to see this page!"
      redirect_to login_path
    end
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    if @todo.save
      flash[:notice] = "New todo created!"
      redirect_to todo_path(@todo)
    else
      flash[:alert] = "Unable to create todo, please try again."
      render :new
    end
  end
  
  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:notice] = "Updated!"
      redirect_to todo_path(@todo)
    else
      flash[:alert] = "Unable to update, please try again!"
      render :edit
    end
  end

  def destroy
    Todo.find(params[:id]).destroy
    redirect_to root_path
  end

  private
    def todo_params
      params.require(:todo).permit(:title, :description)
    end
end
