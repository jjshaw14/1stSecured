module Api
  module V1
    class MeController < BaseController
      def update
        @user = current_user
        if @user.valid_password? params[:password]
          if params[:password_new] === params[:password_confirmation]
            @user.password = params[:password_new]
            if @user.save
              bypass_sign_in(@user)
              render 'show'
            else
              render json: {
                errors: @user.errors
              }, status: 422
            end
          else
            render json: {
              errors: {
                password_new: [ "doesn't match confirmation" ]
              }
            }, status: 422
          end
        else
          render json: { errors: {
            password: [ 'is invalid' ]
          }}, status: 422
        end
      end
      private
      def user_params
        params.permit(:password, :password_new, :password_confirmation)
      end
    end
  end
end
