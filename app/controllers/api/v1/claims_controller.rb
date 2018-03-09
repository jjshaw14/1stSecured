module Api
  module V1
    class ClaimsController < BaseController
      def index
        @claims = Claim.available_to(current_user)
      end
    end
  end
end
