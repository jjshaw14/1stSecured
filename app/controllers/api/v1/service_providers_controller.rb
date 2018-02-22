module Api
  module V1
    class ServiceProvidersController < BaseController
      before_action :set_provider, except: %i[index create]

      def index
        @providers = ServiceProvider.all
      end

      def create
        @provider = ServiceProvider.new(provider_params)
        if @provider.save
          render 'show'
        else
          render json: { errors: @provider.errors }, status: 422
        end
      end

      def update
        if @provider.update_attributes(provider_params)
          render 'show'
        else
          render json: { errors: @provider.errors }, status: 422
        end
      end

      private

      def set_provider
        @provider = ServiceProvider.find(params[:id])
      end

      def provider_params
        params.permit(:name)
      end
    end
  end
end
