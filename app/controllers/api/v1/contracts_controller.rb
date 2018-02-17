module Api
  module V1
    class ContractsController < BaseController
      before_action :set_dealership
      before_action :set_contract, except: [:index, :create]

      def index
        if params[:q].present?
          q = params[:q].gsub(/\s+/, ' ')
          if q.size == 17
            @contracts = Contract.where(vin: q)
          elsif q =~ /[0-9]{1,2}[\/|-][0-9]{2}[\/|-][0-9]{2,4}/
            month, day, year = q.split(/\/|-/).map(&:to_i)
            year += 2000 if year < 2000
            @contracts = Contract.where('DATE(created_at) = ? ', Date.new(year, month, day))
          else
            @contracts = Contract.search_for(q)
          end
        else
          @contracts = Contract.order(:created_at)
        end
      end

      def create
        @contract = Contract.create(contract_params)
        if @contract.save
          render 'show'
        else
          render json: { errors: @contract.errors }, status: 422
        end
      end

      def show
        respond_to do |format|
          format.json
          format.html do
            render layout: nil
          end
          format.pdf do
            render pdf: "contract"
          end
        end
      end

      def update
        if @contract.update_attributes(contract_params)
          render 'show'
        else
          render json: { errors: @contract.errors }, status: 422
        end
      end

      private

      def set_dealership
        if params.key?(:dealership_id)
          @dealership = Dealership.find(params[:dealership_id])
        else
          @dealership = current_user.dealership
        end
      end

      def set_contract
        @contract = @dealership.contracts.find(params[:id])
      end

      def contract_params
        contract_params = params.permit(:vin, :odometer, :purchased_on, :first_name, :last_name, :address1, :address2, :address3, :city, :state, :zip, coverage: [:id], addons: [:id], dealership: [:id])

        contract_params[:coverage]   = Coverage.find(contract_params[:coverage][:id]) if contract_params[:coverage]
        contract_params[:addons]     = contract_params[:addons].map do |addon_params|
          Addon.find(addon_params[:id])
        end if contract_params[:coverage]
        contract_params[:dealership] = Dealership.find(contract_params[:dealership][:id]) if contract_params[:dealership]

        contract_params
      end
    end
  end
end
