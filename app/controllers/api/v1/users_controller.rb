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
            @users = @users.available_to(current_user).order(:created_at)
      end
      def destroy
        @user.deleted_at = Time.now
        if @user.save
          render json: @user, status: 200
        else
          render json: {errors: @user.errors}, status: 422
        end
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
        if @user.id != current_user.id and !current_user.admin?
          render json: { errors: {first_name: ['error' ]} }, status: 422
        elsif @user.update_attributes(user_params)
          render 'show'
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      private

      def set_user
        @user = User.available_to(current_user).find(params[:id])
      end

      def user_params
        user_params = params.permit(:user_type, :first_name, :last_name, :email, :password, dealership: [:id])
        if user_params.key?(:dealership)
          dealership_id = user_params[:dealership][:id]
          if dealership_id
            user_params[:dealership] = Dealership.find(dealership_id)
          elsif current_user.admin?
            user_params.delete(:dealership)
            user_params[:user_type] = nil
            user_params[:dealership_id] = nil
          end
        end
        user_params
      end
    end
  end
end
