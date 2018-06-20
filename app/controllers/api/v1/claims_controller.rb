module Api
  module V1
    class ClaimsController < BaseController
      def index
        if current_user.dealership
            @claims = Claim.by_dealership(current_user.dealership)
        elsif params[:dealership]
          @claims = Claim.by_dealership(params[:dealership])
        else
          @claims = Claim.all
        end
          @claims = @claims.where(contract_id: params[:contract]) if params[:contract]
      end
      def create
        @claim = Claim.new claim_params
        if @claim.save
          render 'show'
        else
          render json: {errors: @claim.errors}, status: 422
        end
      end
      def update
        @claim = Claim.find(params[:id])
        if @claim.update_attributes(claim_params)
          render 'show'
        else
          render json: {errors: @claim.errors}, status: 422
        end
      end
      def edit
        @claim = Claim.find(params[:id])
      end
      def show
        @claim = Claim.find(params[:id])
      end
      private
      def claim_params
        claim_params = params.permit(:odometer, :cost, :shop_name, :shop_phone, :shop_address, :shop_rep, :shop_notes, :authorized_at, :repaired_at, :notes, :can_it_be_safely_moved, :location, :issue, contract: [:id ]).tap{|claims_params|
          claims_params[:cost] ||= 0
          claims_params[:cost_in_cents] = (claims_params.delete(:cost) * 100).to_i
          claims_params[:contract] = Contract.find(claims_params[:contract][:id])
        }
      end
    end
  end
end
