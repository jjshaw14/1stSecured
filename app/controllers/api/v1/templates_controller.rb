module Api
  module V1
    class TemplatesController < BaseController
      before_action :set_template, except: %i[index create preview]

      def index
        @templates = Template.available_to(current_user)
        @templates = if params[:q].present?
                       if params[:q].size == 17
                         @templates.search_vin_for(params[:q])
                       else
                         @templates.search_for(params[:q])
                       end
                     else
                       @templates.order(:created_at)
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
        dummy_contract
        respond_to do |format|
          format.json
          format.html { render pdf: 'contract', template: 'api/v1/contracts/show', show_as_html: true }
          format.pdf { render pdf: 'contract', template: 'api/v1/contracts/show' }
        end
      end

      def preview
        @template = Template.new(template_params)
        dummy_contract
        respond_to do |format|
          format.html { render 'api/v1/contracts/show', layout: nil }
          format.pdf { render 'api/v1/contracts/show' }
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

      def dummy_contract
        @contract ||= Contract.new(template: @template, dealership: Dealership.new, created_by: User.new)
      end

      def set_template
        @template = Template.available_to(current_user).find(params[:id])
      end

      def template_params
        template_params = params.permit(:name, packages: [:id, :name, :terms, coverages: %i[id length_in_months limit_in_miles caveat], addons: %i[id name amount]])

        if template_params.key?(:packages)
          template_params[:packages] = template_params[:packages].map do |package_params|
            if package_params.key?(:coverages)
              package_params[:coverages] = package_params[:coverages].map do |coverage_params|
                Coverage.find_or_initialize_by_params(coverage_params)
              end
            end

            if package_params.key?(:addons)
              package_params[:addons] = package_params[:addons].map do |addon_params|
                addon_params[:amount_in_cents] = (addon_params.delete(:amount) * 100).to_i if addon_params.key?(:amount)
                Addon.find_or_initialize_by_params(addon_params)
              end
            end

            Package.find_or_initialize_by_params(package_params)
          end
        end

        template_params
      end
    end
  end
end
