require "sinatra_helper" 

describe "POST api/v1/trips", type: :request do

  let(:app) { App.new }

  let!(:rider) { create(:rider, email: "rider@example.com") }

  let!(:driver) { create(:driver) }

  let(:trip_params) do {
    email: rider.email,
    start_location: { latitude: 4.6973867, longitude: -74.0493784 },
    end_location: { latitude: 4.654368, longitude: -74.0584483 }
  }
  end

  subject(:create_trip) { post '/api/v1/trips', trip_params.to_json }

  context 'when params are valid' do
    before do
      create(:car, driver: driver) # Active car
      create(:payment_method, rider: rider) # Associated payment method
      create_trip
    end
    
    it 'returns status 200' do
      expect(create_trip.status).to eq 200
    end

    it 'returns trip in body response' do
      expect(json_response['data']).to be_present
      expect(json_response['data']['id']).to be_present
    end   

    it 'create a trip in the database' do
      expect(Trip.count).to eq(1)
    end        
  end

  context 'when there are no drivers available' do
    before do
      create(:car, driver: driver, active: false) # Inactive car
      create_trip
    end

    it 'returns errors -> driver key in body response' do
      expect(json_response['errors']['driver']).to be_present
    end      

    it 'does not create a trip in the database' do
      expect(Trip.count).to eq(0)
    end     
  end  

  context 'when the user does not have a payment method' do
    before do
      create(:car, driver: driver) # Active car
      create_trip
    end

    it 'returns errors -> payment_method key in body response' do
      expect(json_response['errors']['payment_method']).to be_present
    end      

    it 'does not create a trip in the database' do
      expect(Trip.count).to eq(0)
    end     
  end   

  context 'when params are not correct' do
    before do
      trip_params[:email] = "notv_valid@mail"
      trip_params[:start_location] = ""
      create_trip
    end

    it 'returns an email error message' do
      expect(json_response['errors']['email']).to eq(['not a valid email format']) 
      expect(json_response['errors']['start_location']).to eq(['must be filled']) 
    end
  end
end
