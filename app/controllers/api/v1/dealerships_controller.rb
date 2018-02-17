module Api
  module V1
    class DealershipsController < BaseController
      def index
        @dealerships = Dealership.all
      end

      def create
        @dealership = Dealership.new dealership_params
        if @dealership.save
          render 'show'
        else
          render json: { errors: @dealership.errors }, status: 422
        end
      end

      def show
        @dealership = Dealership.find_by(id: params[:id])
      end

      protected

      def dealership_params
        params.permit(:name, :address1, :address2, :address3, :city, :state, :zip)
      end
    end
  end
end
