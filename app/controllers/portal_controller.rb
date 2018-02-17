class PortalController < ApplicationController
  before_action :authenticate_user!
  after_action :set_csrf_cookie

  protected

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
end
