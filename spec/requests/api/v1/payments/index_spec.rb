require "sinatra_helper" 

describe "GET api/v1/payment_method/:email", type: :request do

  let(:app) { App.new }

  let!(:rider) { create(:rider, email: "rider@example.com") }

  let!(:payment_method_list) { create_list(:payment_method, 3, rider: rider) } 

  subject(:get_payment_method) { get "/api/v1/payment_method/#{rider.email}" }

  context 'when params are valid' do
    before do
      get_payment_method
    end
    
    it 'returns status 200' do
      expect(get_payment_method.status).to eq 200
    end

    it 'returns first data row in body response' do
      expect(json_response['data']).to be_present
      expect(json_response['data'][0]['id']).to be_present
      expect(json_response['data'][0]['method_type']).to be_present
    end   

    it "returns the total data generated" do
      expect(json_response['data'].length).to eq(3)
    end        
  end

  context 'when the email does not exist' do
    before do
      get "/api/v1/payment_method/not_valid@example.com"
    end

    it 'returns errors -> email key in body response' do
      expect(json_response['errors']['email']).to be_present
      expect(json_response['errors']['email']).to eq("Email not found")
    end   
  end   
end
