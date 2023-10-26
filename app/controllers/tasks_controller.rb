class TasksController < ApplicationController

  def index
    tasks = Task.all    

    render json: {
      status: "Exitoso",
      message: "tareas Cargados",
      data: tasks
    }, status: :ok
  end

  def show
    task = Task.find(params[:id])
    
    render json: {
      status: "Exitoso",
      message: "Tarea obtenida",
      data: task
    }, status: :ok
  end
  
  

  def create
    task = Task.create(task_params)
    
    if task.save
      render json: {
        status: "Exitoso",
        message: "tarea creada",
        data: task
      }, status: :ok
    else
      render json: {
        status: "Fallido",
        message: "tarea No Creado",
        data: task.errors
      }, status: :unprocessable_entity
    end

  end

  def tasks_for_user
    user_id = params[:user_id] # Obtén el user_id de los parámetros de la solicitud
    tasks = Task.where(user_id: user_id)

    render json: {
      status: "Exitoso",
      message: "Tareas para el usuario cargadas",
      data: tasks
    }, status: :ok
  end
  
  def destroy
    task = Task.find(params[:id])

    if task.destroy
      render json: {
        status: "Exitoso",
        message: "Tarea eliminada",
        data: task
      }, status: :ok
     
    else
      ender json: {
        status: "Fallido",
        message: "No se pudo eliminar la tarea",
        data: task.errors
      }, status: :unprocessable_entity

    end

  end

  
  def update
    task = Task.find(params[:id])
      if task.update(task_params)
        
        render json: {
          status: "Exitoso",
          message: "Tarea editada",
          data: task
        }, status: :ok
      else

        ender json: {
          status: "Fallido",
          message: "No se pudo editar la tarea",
          data: task.errors
        }, status: :unprocessable_entity
      end
  end
  

  private

  def task_params
    params.permit(:name, :label, :priority, :state, :date, :description, :user_id)    
  end
  

end