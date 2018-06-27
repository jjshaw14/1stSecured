module Api
  module V1
    class ContractsController < BaseController
      before_action :set_contract, except: %i[index create]

      def index
        @contracts = Contract.available_to(current_user).where(deleted_at: nil).includes(:dealership)

        if params.key?(:dealership)
          @contracts = @contracts.where(dealership_id: params[:dealership])
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
        end
        if params[:unsigned].present? and ActiveModel::Type::Boolean.new.cast(params[:unsigned]) === true
          @contracts = @contracts.where(signed_copy: nil)
        end
        @contracts = @contracts.order(purchased_on: :desc)
      end
      def destroy
        @contract.deleted_at = Time.now
        if @contract.save
          render json: @contract, status: 200
        else
          render json: {errors: @contract.errors }, status: 422
        end
      end
      def create
        @contract = contract_params[:dealership].contracts.build(contract_params) do |c|
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

      def set_contract
        @contract = Contract.available_to(current_user).find(params[:id])
      end

      def contract_params
        contract_params = params.permit(:contract_number, :stock_number, :price, :vin, :odometer, :purchased_on, :first_name, :last_name, :address1, :address2, :address3, :city, :state, :zip, :email, :mobile_number, :home_number, :work_number, :signed_copy, :coverage_id, addons: [:id], template: [:id, :dealership_id])
        contract_params[:price_in_cents] = (contract_params.delete(:price) * 100).to_i if contract_params.key?(:price)
        if contract_params[:coverage_id]

          contract_params[:addons] = contract_params[:addons].map do |addon_params|
            puts addon_params
            Addon.find(addon_params[:id])
          end
        else
          contract_params[:addons] = []
        end

        if contract_params[:template]
          contract_params[:template] = Template.available_to(current_user).find(contract_params[:template][:id])
          contract_params[:dealership] = contract_params[:template].dealership
        end

        contract_params
      end
    end
  end
end
