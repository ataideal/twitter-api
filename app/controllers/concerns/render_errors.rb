module RenderErrors
  extend ActiveSupport::Concern

  included do
    def render_errors(errors: [], message: "", status: 422)
      render json: { errors: errors, message: message }, status: status
    end
  end
end