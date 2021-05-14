require 'Deck'

RSpec.describe Deck do 
  deck = Deck.new

  context "when new Deck is initialized" do 
    it "has a 52 cards in the deck" do 
      expect(deck.cards.count).to eq(52)
    end 
  end 
end 
