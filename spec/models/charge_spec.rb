require "sinatra_helper"

describe Charge, type: :model do

  describe "Associations" do
    it { should belong_to(:trip) } 
    it { should belong_to(:payment_method) } 
  end  

  let(:charge) { build(:charge, total: "") }

  describe 'Model Validation' do 
    context 'when creating a new record' do
      it "has none to begin with" do
        expect(Charge.count).to eq 0
      end

      it "has one after adding one" do
        create(:charge)
        expect(Charge.count).to eq 1
      end    
    end    

    context 'when data is not completed' do
      it 'returns validation' do
        charge.save
        expect(charge).to be_invalid
        expect(Charge.count).to eq 0
      end
    end
  end
end
