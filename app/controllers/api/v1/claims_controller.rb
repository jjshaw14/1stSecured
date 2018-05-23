module Api
  module V1
    class ClaimsController < BaseController
      def index
        @claims = Claim.available_to(current_user)
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
