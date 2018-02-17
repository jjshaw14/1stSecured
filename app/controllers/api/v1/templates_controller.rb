module Api
  module V1
    class TemplatesController < BaseController
      before_action :set_dealership
      before_action :set_template, except: [:index, :create, :preview]

      def index
        if params[:q].present?
          if params[:q].size == 17
            @templates = Template.search_vin_for(params[:q])
          else
            @templates = Template.search_for(params[:q])
          end
        else
          @templates = Template.order(:created_at)
        end
      end

      def create
        @template = @dealership.templates.build(template_params)
        if @template.save
          render 'show'
        else
          render json: { errors: @template.errors }, status: 422
        end
      end

      def show
        respond_to do |format|
          format.json
          format.html do
            render layout: nil
          end
          format.pdf do
            render pdf: 'template'
          end
        end
      end

      def preview
        @template = Template.new(template_params)
        @contract = Contract.new(template: @template, dealership: Dealership.new, created_by: User.new)
        respond_to do |format|
          format.html do
            render 'api/v1/contracts/show'
          end
        end
      end

      def update
        if @template.update_attributes(template_params)
          render 'show'
        else
          render json: { errors: @template.errors }, status: 422
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

      def set_template
        @template = @dealership.templates.find(params[:id])
      end

      def template_params
        template_params = params.permit(:name, packages: [:id, :name, :terms, coverages: [:id, :length_in_months, :limit_in_miles, :caveat], addons: [:id, :name, :amount]])

        template_params[:packages] = template_params[:packages].map do |package_params|
          package_params[:coverages] = package_params[:coverages].map do |coverage_params|
            Coverage.new(coverage_params)
          end if package_params.key?(:coverages)

          package_params[:addons] = package_params[:addons].map do |addon_params|
            addon_params[:amount_in_cents] = (addon_params.delete(:amount) * 100).to_i if addon_params.key?(:amount)
            Addon.new(addon_params)
          end if package_params.key?(:addons)

          Package.new(package_params)
        end if template_params.key?(:packages)

        template_params
      end
    end
  end
end
