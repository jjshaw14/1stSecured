module Api
  module V1
    class ClaimsController < BaseController
      def index
        @claims = Claim.available_to(current_user).where(deleted_at: nil)
        @claims = @claims.by_dealership(Dealership.find(params[:dealership])) if params[:dealership]
        @claims = @claims.where(contract_id: params[:contract]) if params[:contract]
      end
      def destroy
        @claim = Claim.available_to(current_user).find(params[:id])
        @claim.deleted_at = Time.now
        if @claim.save
          render json: @claim, status: 200
        else
          render json: {errors: @claim.errors}, status: 422
        end
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
