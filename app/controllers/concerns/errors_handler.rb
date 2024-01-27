module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_validation_exception
    rescue_from ActionDispatch::Http::Parameters::ParseError, with: :render_bad_request
  end

  private

  def render_bad_request(messages = "Bad request")
    messages = "Bad request" unless messages.is_a?(String) || messages.is_a?(Array)
    render json: {errors: Array.wrap(messages)}, status: :bad_request
  end

  def render_validation_errors(object = nil, code = nil)
    object ||= instance_variable_get(:"@#{controller_name.underscore.singularize}")
    errors = object.respond_to?(:nested_error_messages) ? object.nested_error_messages : object.errors.full_messages
    body = {errors: errors}
    body[:code] = code if code
    render json: body, status: :unprocessable_entity
  end

  def render_validation_exception
    render_validation_errors
  end
end
