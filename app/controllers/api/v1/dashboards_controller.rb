module Api
  module V1
    class DashboardsController < BaseController
      def index
        @dealership = Dealership.available_to(current_user).find(params[:id])
      end

    end
  end
end


