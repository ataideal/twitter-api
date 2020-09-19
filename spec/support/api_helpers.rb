# frozen_string_literal: true

module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end

  def serialize_object(object)
    ActiveModelSerializers::SerializableResource.new(object).to_json
  end
end
