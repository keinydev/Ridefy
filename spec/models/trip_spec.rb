require "sinatra_helper"

describe Trip, type: :model do

  describe "Associations" do
    it { should belong_to(:rider) }
    it { should belong_to(:driver) }
    it { should belong_to(:car) }
  end  

  let(:trip) { build(:trip, start_location: "") }

  describe 'Model Validation' do 
    context 'when creating a new record' do
      it "has none to begin with" do
        expect(Trip.count).to eq 0
      end

      it "has one after adding one" do
        create(:trip)
        expect(Trip.count).to eq 1
      end    
    end    

    context 'when data is not completed' do
      it 'returns validation' do
        trip.save
        expect(trip).to be_invalid
        expect(Trip.count).to eq 0
      end
    end
  end
end
