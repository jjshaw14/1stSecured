class SiteController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :maintenance_mode

  private

  def maintenance_mode
    render 'maintenance'
  end
end
