require 'Dealer'

RSpec.describe Dealer do 
  dealer = Dealer.new

  context "when new Dealer is initialized" do 
    it "has a default name" do 
      expect(dealer.name).to eq('Dealer')
    end 

    it "has an empty hand" do 
      expect(dealer.hand).to be_empty
    end 
  end 
end 
