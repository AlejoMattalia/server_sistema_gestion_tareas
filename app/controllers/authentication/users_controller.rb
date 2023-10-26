module Authentication
  class UsersController < ApplicationController
    
    def index
      users = User.all
      
      render json: {
        status: "Exitoso",
        message: "Usuarios Cargados",
        data: users
      }, status: :ok
    end


    # def show
    #   user = User.find(params[:id])
      
    #   render json: {
    #     status: "Exitoso",
    #     message: "Usuario Cargados",
    #     data: user
    #   }, status: :ok
    # end
    
    def create
      user = User.new(user_params)

      if(user.save)
        render json: {
          status: "Exitoso",
          message: "Usuario Creado",
          data: user
        }, status: :ok

      else
        render json: {
          status: "Fallido",
          message: "Usuario No Creado",
          data: user.errors
        }, status: :unprocessable_entity
      end    
    end

  
    private

    def user_params
      params.permit(:username, :email, :password)      
    end
    
  end
end