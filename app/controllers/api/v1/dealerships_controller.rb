module Api
  module V1
    class DealershipsController < BaseController
      before_action :set_dealership, except: %i[index create]

      def index
        @dealerships = Dealership.available_to(current_user).where(deleted_at: nil)
      end

      def destroy
        @dealership.deleted_at = Time.now
        if @dealership.save
          render json: @dealership, status: 200
        else
          render json: {errors: @dealership.errors}, status: 422
        end
      end

      def create
        @dealership = Dealership.new dealership_params
        if @dealership.save
          render 'show'
        else
          render json: { errors: @dealership.errors }, status: 422
        end
      end

      def update
        if @dealership.update_attributes dealership_params
          render 'show'
        else
          render json: { errors: @dealership.errors }, status: 422
        end
      end

      protected

      def dealership_params
        params.permit(:name, :address1, :address2, :address3, :city, :state, :zip, :phone, :contract_preface)
      end

      def set_dealership
        @dealership = Dealership.available_to(current_user).find_by(id: params[:id])
      end
    end
  end
end
