module Api
  module V1
    class TemplatesController < BaseController
      before_action :set_template, except: %i[index create preview, new]

      def index
        @templates = Template.available_to(current_user).where(deleted_at: nil)
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
        @template = Template.new(template_params)
        if @template.save
          render 'show'
        else
          render json: { errors: @template.errors }, status: 422
        end
      end
      def terms
        render json: DEFAULT_TERMS
      end
      def destroy
        @template.deleted_at = Time.now
        if @template.save
          render json: @template, status: 200
        else
          render json: {errors: @template.errors}, status: 422
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

      def new
        @template = Template.default(params[:dealership_id], params[:template_id])
        respond_to do |f|
          f.json {render 'api/v1/templates/show' }
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
        template_params = params.permit(:terms, :name, :dealership_id, packages: [:id, :hide_package, :name, :terms, coverages: %i[id length_in_months limit_in_miles caveat amount fee up_to ], addons: %i[id name amount fee hide_numbers]])

        if template_params.key?(:packages)
          template_params[:packages] = template_params[:packages].map.with_index do |package_params, i|
            if package_params.key?(:coverages)
              package_params[:coverages] = package_params[:coverages].map.with_index do |coverage_params, k|
                coverage_params[:amount] ||= 0
                coverage_params[:fee] ||= 0
                coverage_params[:cost_in_cents] = (coverage_params.delete(:amount) * 100).to_i if coverage_params.key?(:amount)
                coverage_params[:fee_in_cents] = (coverage_params.delete(:fee) * 100).to_i if coverage_params.key?(:fee)
                Coverage.find_or_initialize_by_params(coverage_params).tap{|c|
                  c.order = k
                }
              end
            end
            if package_params.key?(:addons)
              package_params[:addons] = package_params[:addons].map.with_index do |addon_params, k|
                addon_params[:amount] ||= 0
                addon_params[:fee] ||= 0
                addon_params[:cost_in_cents] = (addon_params.delete(:amount) * 100).to_i if addon_params.key?(:amount)
                addon_params[:fee_in_cents] = (addon_params.delete(:fee) * 100).to_i if addon_params.key?(:fee)
                Addon.find_or_initialize_by_params(addon_params).tap{|a|
                  a.order = k
                }
              end
            end
            Package.find_or_initialize_by_params(package_params).tap{|p|
              p.order = i
            }
          end
        end
        template_params
      end
    end
  end
end
