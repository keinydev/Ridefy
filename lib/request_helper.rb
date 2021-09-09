require 'http'

module RequestHelpers
	extend self
	
	module Wompi
		extend self

	  def post(option, body)
	  	url = "#{ENV["WOMPI_URL"]}#{option}"
	  	response = HTTP[:accept => "application/json"].auth("Bearer #{ENV['WOMPI_PRIVATE_KEY']}").post(url, :json => body)
	  end
	end

  def json_response(params)
    JSON.parse(params)
  end
end
