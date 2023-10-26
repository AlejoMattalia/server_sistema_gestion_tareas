require 'jwt'

module Authentication

  class SessionsController < ApplicationController
    
    def create
      user = User.find_by(username: params[:usernameOrEmail]) || User.find_by(email: params[:usernameOrEmail])

      if user&.authenticate(params[:password])
        render json: { message: "Autenticación exitosa", user: user, token: generate_token(user)}, status: :ok
      else  
        render json: { message: "Autenticación fallida"}, status: :unauthorized
      end

    end

    def user_data
      user = current_user
      if user
        render json: { user: user }, status: :ok
      else
        render json: { message: "Usuario no encontrado" }, status: :not_found
      end
    end
      

    private
    
    def generate_token(user)
      payload = { user_id: user.id }
      secret_key = Rails.application.secrets.secret_key_base
      token = JWT.encode(payload, secret_key, 'HS256')
      token
    end

    def current_user
      if request.headers['Authorization'].present?
        token = request.headers['Authorization'].split(' ').last
        begin
          payload = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
          user_id = payload[0]['user_id']
          return User.find(user_id)
        rescue JWT::DecodeError
          return nil
        end
      else
        return nil
      end
    end

  end
end
