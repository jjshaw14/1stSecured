class PortalController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  after_action :set_csrf_cookie

  protected

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
end
