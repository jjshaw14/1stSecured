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
    end
  end
end
