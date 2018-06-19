module Api
  module V1
    class ClaimsController < BaseController
      def index
        if current_user.dealership
            @claims = Claim.by_dealership(current_user.dealership)
        elsif params[:dealership]
          @claims = Claim.by_dealership(params[:dealership])
        else
          @claims = Claims.all
        end
          @claims = @claims.where(contract_id: params[:contract]) if params[:contract]
      end
      def create
      end
      def update
      end

      private
      def claim_params
        claim_params = params.permit(:odometer, :cost)
      end
    end
  end
end
