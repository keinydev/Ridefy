require "sinatra_helper" 

describe "POST api/v1/trips", type: :request do

  let(:driver) { create(:driver) }

  let(:rider) { create(:rider) }

  let(:trip_params) do {
    email: rider.email,
    start_location: { latitude: 4.6973867, longitude: -74.0493784 },
    end_location: { latitude: 4.654368, longitude: -74.0584483 }
  }
  end

  subject(:create_trip) { post '/api/v1/trips', body: trip_params, as: :json }

  context 'when params are valid' do
    before do
      create_trip
    end
    
    it 'returns status 200' do
      expect(response).to be_successful
    end

    it 'returns target key in body response' do
      expect(json_response['trip']).to be_present
    end      
  end

  context 'when params are not correct' do
    before do
      trip_params[:email] = "notv_valid@mail"
      create_trip
    end

    it 'returns an error message' do
      expect(json_response['errors']).to eq(['You need to sign in or sign up before continuing.']) 
    end
  end
end
