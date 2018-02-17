module Api
  module V1
    class VinController < BaseController
      def show
        info = VinLookupService.new.execute(params[:q])
        render json: info
      end
    end
  end
end
