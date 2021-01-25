# frozen_string_literal: true

module JsonRequestHelpers
  def json_response
    @json ||= JSON.parse(response.body)
  end
end
