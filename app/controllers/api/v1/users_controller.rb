module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, except: [:index, :create]

      def index
        if params[:q].present?
          if params[:q].size == 17
            @users = User.search_vin_for(params[:q])
          else
            @users = User.search_for(params[:q])
          end
        else
          @users = User.all
        end

        if params.key?(:admin)
          if params[:admin] == 'true' || params[:admin].to_i == 1
            @users = @users.admin
          else
            @users = @users.customer
          end
        end

        @users = @users.order(:created_at)
      end

      def create
        @user = User.create(user_params)
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
            render pdf: "user"
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
        user_params = params.permit(:vin, :odometer, :purchased_on, :first_name, :last_name, :address1, :address2, :address3, :city, :state, :zip, dealership: [:id])

        user_params[:dealership] = Dealership.find(user_params[:dealership][:id]) if user_params[:dealership]

        user_params
      end
    end
  end
end