module Request
  module Helpers

    def json_response
      JSON.parse(response.body)
    end
  end
end