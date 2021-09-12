require "sinatra_helper"

describe PaymentMethod, type: :model do

  describe "Associations" do
    it { should belong_to(:rider) }
    it { should have_many(:charges) }
  end  

  let(:payment_method) { build(:payment_method, source_id: "") }

  describe 'Model Validation' do 
    context 'when creating a new record' do
      it "has none to begin with" do
        expect(PaymentMethod.count).to eq 0
      end

      it "has one after adding one" do
        create(:payment_method)
        expect(PaymentMethod.count).to eq 1
      end    
    end    

    context 'when data is not completed' do
      it 'returns validation' do
        payment_method.save
        expect(payment_method).to be_invalid
        expect(PaymentMethod.count).to eq 0
      end
    end
  end
end
