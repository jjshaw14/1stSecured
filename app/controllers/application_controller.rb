class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def info_for_paper_trail
    { request_id: SecureRandom.uuid, request_ip: request.ip }
  end
end
