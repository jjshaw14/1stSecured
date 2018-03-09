module Api
  module V1
    class FeesController < BaseController
      before_action :set_fee, except: %i[index create]

      def index
        enforce_view_permission Fee

        @fees = Fee.all
      end

      def create
        @fee = Fee.new(fee_params)
        if @fee.save
          render 'show'
        else
          render json: { errors: @fee.errors }, status: 422
        end
      end

      def update
        if @fee.update_attributes(fee_params)
          render 'show'
        else
          render json: { errors: @fee.errors }, status: 422
        end
      end

      private

      def set_fee
        @fee = Fee.find(params[:id])
      end

      def fee_params
        params.permit(:length_in_months, :cost_in_cents)
      end
    end
  end
end
