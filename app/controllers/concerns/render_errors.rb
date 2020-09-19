# frozen_string_literal: true

module RenderErrors
  extend ActiveSupport::Concern

  included do

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render_errors(errors: [*exception], message: exception.to_s, status: 404)
    end

    def render_errors(errors: [], message: '', status: 422)
      render json: { errors: errors, message: message }, status: status
    end
  end
end
