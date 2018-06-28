module Api
  module V1
    class DocumentsController < BaseController
      def index
        @documents = Document.available_to(current_user)
        @documents = @documents.where(dealership_id: params[:dealership]) if current_user.admin?
      end
      def show
        @document = Document.available_to(current_user).find(params[:id])
      end
      def destroy
        @document = Document.available_to(current_user).find(params[:id])
        @document.deleted_at = Time.now
        if @document.save
          render json: @document, status: 200
        else
          render json: {errors: @document.errors}, status: 422
        end
      end
      def create
        @document = Document.new document_params
        if current_user.dealership.present? && current_user.dealership_id != @document.dealership_id
          render json: {errors: {authorization: ['unable to complete at this time']}}, status: 422
        elsif @document.save
          render 'show'
        else
          render json: {errors: @document.errors}, status: 422
        end
      end
      def update
        @document = Document.available_to(current_user).find(params[:id])
        if @document.update_attributes(document_params)
          render 'show'
        else
          render json: {errors: @document.errors}, status: 422
        end
      end
      private
      def document_params
        document_params = params.permit(:id, :name, :attachment, dealership: [:id]).tap{ |document_params|
          document_params[:dealership_id] = document_params.delete(:dealership)[:id] if document_params[:dealership]
        }
      end
    end
  end
end
