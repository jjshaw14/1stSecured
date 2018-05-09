module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, except: %i[index create]

      def index
        @users = if params[:q].present?
                   if params[:q].size == 17
                     User.search_vin_for(params[:q])
                   else
                     User.search_for(params[:q])
                   end
                 else
                   User.all
                 end

#        if params.key?(:admin)
#          @users = if params[:admin] == 'true' || params[:admin].to_i == 1
#                     @users.admin
#                   else
#                     @users.customer
#                   end
#       end

        @users = @users.order(:created_at)
      end

      def create
        @user = User.create(user_params) do |u|
          u.password ||= SecureRandom.hex(20)
        end

        if @user.save
          render 'show'
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      def show
        respond_to do |format|
          format.json
          format.html do
            render layout: nil
          end
          format.pdf do
            render pdf: 'user'
          end
        end
      end

      def update
        if @user.update_attributes(user_params)
          render 'show'
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        user_params = params.permit(:first_name, :last_name, :email, :password, dealership: [:id])
        user_params[:dealership] = Dealership.find(user_params[:dealership][:id]) if user_params.key?(:dealership)
        user_params
      end
    end
  end
end
