require "sinatra_helper" 

describe "POST api/v1/payment_methods", type: :request do

  let(:app) { App.new }

  let(:rider) { create(:rider) }

  let(:token) { "tok_test_13341_08FE70506A24a4CABE63259e342b662b" }

  let(:acceptance_token) { "eyJhbGciOiJIUzI1NiJ9eyJjb250cmFjdF9pZCI6MSwicGVybWFsaW5..." }
  
  let(:payment_method_params) do {
    email: rider.email,
    method_type: "CARD",
    token: token,
    acceptance_token: acceptance_token
  }
  end

  subject(:post_payment_method) { post "/api/v1/payment_methods", payment_method_params.to_json }

  context 'when params are valid' do
    before do
      stub_request(:post, "https://sandbox.wompi.co/v1/payment_sources").
         with(
           body: "{\"type\":\"CARD\",\"token\":\"#{token}\",\"customer_email\":\"#{rider.email}\",\"acceptance_token\":\"#{acceptance_token}\"}",
           headers: {
            'Accept'=>'application/json',
            'Authorization'=>"Bearer #{ENV['WOMPI_PRIVATE_KEY']}",
            'Connection'=>'close',
            'Content-Type'=>'application/json; charset=UTF-8',
            'Host'=>'sandbox.wompi.co',
            'User-Agent'=>'http.rb/5.0.1'
           }).
         to_return(status: 200, body: "{\"data\": { \"id\": 16377, \"public_data\": { \"type\": \"CARD\" }, \"token\": \"#{token}\",\"type\": \"CARD\", \"status\": \"AVAILABLE\",\"customer_email\": \"#{rider.email}\"},\"meta\": {}}", headers: {})
      
      post_payment_method
    end

    it 'returns status 200' do
      expect(post_payment_method.status).to eq 200
    end

    it 'returns first data row in body response' do
      expect(json_response['data']).to be_present
      expect(json_response['data']['id']).to be_present
      expect(json_response['data']['method_type']).to be_present
      expect(json_response['data']['source_id']).to be_present
      expect(json_response['data']['rider']).to be_present
    end      
  end

  context 'when the method type does not exist' do
    before do
      payment_method_params[:method_type] = "Invalid"
      post_payment_method
    end

    it 'returns errors -> method_type key in body response' do
      expect(json_response['errors']['method_type']).to be_present
      expect(json_response['errors']['method_type']).to eq(["This app only accept CARD or NEQUI"])
    end   
  end   
end
