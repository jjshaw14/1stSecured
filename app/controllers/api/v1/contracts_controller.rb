module Api
  module V1
    class ContractsController < BaseController
      before_action :set_dealership
      before_action :set_contract, except: %i[index create]

      def index
        @contracts = if @dealership.nil?
                       Contract.all
                     else
                       @dealership.contracts
                     end

        if params[:q].present?
          q = params[:q].gsub(/\s+/, ' ')
          if q.size == 17
            @contracts = @contracts.where(vin: q)
          elsif q.match?(%r([0-9]{1,2}[\/|-][0-9]{2}[\/|-][0-9]{2,4}))
            month, day, year = q.split(%r{\/|-}).map(&:to_i)
            year += 2000 if year < 2000
            @contracts = @contracts.where('DATE(created_at) = ? ', Date.new(year, month, day))
          else
            @contracts = @contracts.search_for(q)
          end
        else
          @contracts = @contracts.order(:created_at)
        end
      end

      def create
        @contract = @dealership.contracts.build(contract_params) do |c|
          c.created_by = current_user
        end

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
            render pdf: 'contract', margin: { top: 5, left: 5, bottom: 5, right: 5 }
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
        @dealership = if params.key?(:dealership_id)
                        Dealership.find(params[:dealership_id])
                      else
                        current_user.dealership
                      end
      end

      def set_contract
        @contract = @dealership.contracts.find(params[:id])
      end

      def contract_params
        contract_params = params.permit(:stock_number, :vin, :odometer, :purchased_on, :first_name, :last_name, :address1, :address2, :address3, :city, :state, :zip, :email, :mobile_number, :home_number, :work_number, coverage: [:id], addons: [:id], template: [:id])

        contract_params[:coverage] = Coverage.find(contract_params[:coverage][:id]) if contract_params[:coverage]

        if contract_params[:coverage]
          contract_params[:addons] = contract_params[:addons].map do |addon_params|
            Addon.find(addon_params[:id])
          end
        end

        contract_params[:template] = @dealership.templates.find(contract_params[:template][:id]) if contract_params[:template]

        contract_params
      end
    end
  end
end
