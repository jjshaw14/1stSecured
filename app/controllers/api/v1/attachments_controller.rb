module Api
  module V1
    class AttachmentsController < BaseController
      def show
        @contract = Contract.available_to(current_user).find(params[:contract_id])
        if Rails.env.production?
          redirect_to @contract.signed_copy.url
        else
          send_file @contract.signed_copy.file.path, disposition: :inline
        end
      end
      def claim
        @claim = Claim.available_to(current_user).find(params[:id])
        if Rails.env.production?
          redirect_to @claim.attachment.url
        else
          send_file @claim.attachment.file.path, disposition: :inline
        end
      end
      def document
        @document = Document.available_to(current_user).find(params[:id])
        if Rails.env.production?
          redirect_to @document.attachment.url
        else
          send_file @document.attachment.file.path, disposition: :inline
        end
      end
    end
  end
end
