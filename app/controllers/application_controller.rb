class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'error_404', content_type: 'text/html'
  end
end
