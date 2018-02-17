module Api
  class BaseController < ApplicationController
    before_action :authenticate_user!

    protected

    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end
  end
end
