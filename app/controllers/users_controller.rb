class UsersController < ApplicationController

    before_action :authorized, only: [:auto_login, :update, :destroy]

    # REGISTER
    def create
      @user = User.create(user_params)
      if @user.valid?
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid email or password"}, status: :unprocessable_entity
      end
    end
  
    # LOGGING IN
    def login
      @user = User.find_by(email: params[:email])
  
      if @user && @user.authenticate(params[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid email or password"}, status: :unprocessable_entity
      end
    end
  
  
    def auto_login
      render json: @user
    end

    # PATCH or PUT /users/1
    def update
      # check_user 
      if @user.update(user_params)
        render json: {
                      status: "Success",
                      message: "User updated.",
                      data: @user
                      }, status: :ok
      else
        render json: {
                      status: "Error",
                      message: "User not updated.",
                      data: @user.errors
                      }, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      # auto_login
      # check_user
      if @user.present?
        @user.destroy
        render json: {
            status: "Success",
            message: "Journal deleted.",
        }, status: 204
      else
        render json: {
            status: "Error",
            message: "Journal not deleted.",
        }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:username, :password, :email)
    end
end
