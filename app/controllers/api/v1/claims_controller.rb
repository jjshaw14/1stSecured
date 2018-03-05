module Api
  module V1
    class ClaimsController < BaseController
      def index
        @dealership = Dealership.find(params[:dealership_id])
        @claims = @dealership.claims
      end
    end
  end
end
