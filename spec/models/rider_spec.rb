require "sinatra_helper"

describe Rider, type: :model do

  describe "Associations" do
    it { should have_many(:payment_methods) }
    it { should have_many(:trips) }
  end  

  let!(:rider) { create(:rider) }

  let!(:trip) { create(:trip, rider: rider) }

  let!(:payment_method) { create(:payment_method, rider: rider) }

  describe 'Scopes' do
    context 'rider ongoing' do 
      it "returns data when the rider is in a current trip" do
        expect(Rider.rider_ongoing(rider.email).length).to eq(1)
      end  
    end  

    context 'rider authorized to request a trip' do 
      it "returns data when the rider has registered payment methods" do
        expect(Rider.rider_authorized(rider.email).length).to eq(1)
      end  
    end  

    context 'rider payment methods' do 
      it "returns data when the payment id is associated to the rider" do
        expect(Rider.rider_payment_method(rider.email, payment_method.id).length).to eq(1)
      end  
    end       
  end
end
