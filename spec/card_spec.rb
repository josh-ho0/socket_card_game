require 'Card'

RSpec.describe Card do 
  card = Card.new("A", "Hearts")

  context "when a new card is initialized" do 
    it "has a rank" do 
      expect(card.rank).to eq("A")
    end 

    it "has a suit" do 
      expect(card.suit).to eq("Hearts")
    end 
  end 
end 
