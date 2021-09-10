module Request
  module Helpers

    def json_response
      JSON.parse(last_response.body)
    end
  end
end
