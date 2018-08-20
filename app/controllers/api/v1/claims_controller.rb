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
        if @claim.contract.nil? || ( current_user.dealership.present? && current_user.dealership_id != @claim.contract.dealership_id )
          render json: {errors: {authorization: ['unable to complete at this time']}}, status: 422
        elsif @claim.save
          render 'show'
        else
          render json: {errors: @claim.errors}, status: 422
        end
      end
      def update
        @claim = Claim.available_to(current_user).find(params[:id])
        if @claim.update_attributes(claim_params)
          render 'show'
        else
          render json: {errors: @claim.errors}, status: 422
        end
      end
      def edit
        @claim = Claim.available_to(current_user).find(params[:id])
      end
      def show
        @claim = Claim.available_to(current_user).find(params[:id])
      end
      private
      def claim_params
        claim_params = params.permit(:authorization_number, :attachment, :odometer, :cost, :shop_name, :shop_phone, :shop_address, :shop_rep, :shop_notes, :authorized_at, :repaired_at, :notes, :can_it_be_safely_moved, :location, :issue, contract: [:id ]).tap{|claims_params|
          claims_params[:cost] ||= 0 if claims_params[:cost]
          claims_params[:cost_in_cents] = (claims_params.delete(:cost) * 100).to_i if claims_params[:cost]
          claims_params[:contract] = Contract.find(claims_params[:contract][:id]) if claims_params[:contract]
        }
      end
    end
  end
end
