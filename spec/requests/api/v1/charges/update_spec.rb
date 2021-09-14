require "sinatra_helper" 

describe "PUT api/v1/charges/:id", type: :request do

  let(:app) { App.new }

  let(:rider) { create(:rider) }

  let!(:trip) { create(:trip, rider: rider) }

  let!(:charge) { create(:charge, trip: trip, total: 49900) }

  let!(:payment_method) { create(:payment_method, rider: rider, source_id: 16377) } 

  let(:acceptance_token) { "eyJhbGciOiJIUzI1NiJ9eyJjb250cmFjdF9pZCI6MSwicGVybWFsaW5..." }

  let(:time_now) { Time.now.to_i }
  
  let(:charge_params) do {
    email: rider.email,
    payment_method_id: payment_method.id,
    acceptance_token: acceptance_token
  }
  end

  subject(:put_charge) { put "/api/v1/charges/#{charge.id}", charge_params.to_json }

  context 'when params are valid' do
    before do
      stub_request(:post, "https://sandbox.wompi.co/v1/transactions").
         with(
           body: "{\"amount_in_cents\":4990000,\"currency\":\"COP\",\"customer_email\":\"#{rider.email}\",\"payment_method\":{\"installments\":2},\"reference\":\"Trip-#{trip.id}-#{time_now}\",\"payment_source_id\":\"#{payment_method.source_id}\"}",
           headers: {
          'Accept'=>'application/json',
          'Authorization'=>"Bearer #{ENV['WOMPI_PRIVATE_KEY']}",
          'Connection'=>'close',
          'Content-Type'=>'application/json; charset=UTF-8',
          'Host'=>'sandbox.wompi.co',
          'User-Agent'=>'http.rb/5.0.1'
           }).
         to_return(status: 200, body: "{\"data\":{\"id\": \"113341-1631302022-26141\",\"created_at\": \"2021-09-10T19:27:03.458Z\",\"amount_in_cents\": 4990000,\"reference\": \"Trip-#{trip.id}-#{time_now}\",\"customer_email\": \"#{rider.email}\",\"currency\": \"COP\",\"payment_method_type\": \"CARD\",\"payment_method\": {\"type\": \"CARD\",\"extra\": {\"bin\": \"424242\",\"name\": \"VISA-4242\",\"brand\": \"VISA\",\"exp_year\": \"29\",\"exp_month\": \"06\",\"last_four\": \"4242\",\"card_holder\": \"#{rider.first_name}\"},\"installments\": 2},\"status\": \"PENDING\",\"status_message\": null,\"billing_data\": null,\"shipping_address\": null,\"redirect_url\": null,\"payment_source_id\": 16377,\"payment_link_id\": null,\"customer_data\": null,\"bill_id\": null,\"taxes\": []},\"meta\": {}}", headers: {})

      put_charge
    end
    
    it 'returns status 200' do
      expect(put_charge.status).to eq 200
    end

    it 'returns data in body response' do
      expect(json_response['data']).to be_present 
    end      
  end  

  context 'when the payment method does not exist' do
    before do
      charge_params[:payment_method_id] = 500
      put_charge
    end

    it 'returns errors -> payment_method key in body response' do
      expect(json_response['errors']['payment_method']).to be_present
      expect(json_response['errors']['payment_method']).to eq("Payment Method not found")
    end   
  end   
end
