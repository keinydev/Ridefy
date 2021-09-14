require "sinatra_helper" 

describe "PUT api/v1/trips/:id", type: :request do

  let(:app) { App.new }

  let!(:rider) { create(:rider, email: "rider@example.com") }

  let!(:driver) { create(:driver) }

  let!(:car) { create(:car, driver: driver) }

  let(:trip) { create(:trip, car: car, driver: driver, rider: rider, start_location: { latitude: 4.6973867, longitude: -74.0493784 }) }

  let(:trip_params) do {
    end_location: { latitude: 4.654368, longitude: -74.0584483 }
  }
  end

  subject(:finish_trip) { put "/api/v1/trips/#{trip.id}", trip_params.to_json }

  context 'when params are valid' do
    before do
      finish_trip
    end
    
    it 'returns status 200' do
      expect(finish_trip.status).to eq 200
    end

    it 'returns trip in body response' do
      expect(json_response['data']).to be_present
      expect(json_response['data']['id']).to be_present
    end       
  end

  context 'when location has { latitude: 4.6973867, longitude: -74.0493784 }' do
    before do
      finish_trip
    end

    it 'returns 8461.93 as total to charge in body response' do
      expect(json_response['data']['charge']['total']).to eq(8387.93)
    end       
  end  

  context 'when the trip was already finished' do
    before do
      sec_trip = create(:trip, car: car, driver: driver, rider: rider, start_location: { latitude: 4.6973867, longitude: -74.0493784 })
      put "/api/v1/trips/#{sec_trip.id}", trip_params.to_json 
      put "/api/v1/trips/#{sec_trip.id}", trip_params.to_json 
    end

    it 'returns errors -> trip key in body response' do
      expect(json_response['errors']['trip']).to be_present
      expect(json_response['errors']['trip']).to eq("This trip has ended, no changes applied")
    end  
  end  

  context 'when params are not correct' do
    before do
      trip_params[:end_location] = ""
      finish_trip
    end

    it 'returns an email error message' do
      expect(json_response['errors']['end_location']).to eq(['must be filled']) 
    end
  end

  context 'when the trips does not exist' do
    before do
      put "/api/v1/trips/1001", trip_params.to_json 
    end

    it 'returns errors -> trip key in body response' do
      expect(json_response['errors']['trip']).to be_present
      expect(json_response['errors']['trip']).to eq("Trip not found")
    end   
  end   
end
