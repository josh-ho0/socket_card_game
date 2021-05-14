require './lib/card'

class Deck  
  attr_reader :cards  
  
  SUITS = %w( Spades Heart Diamond Clubs ).freeze
  RANKS = %w( A 2 3 4 5 6 7 8 9 10 J Q K ).freeze

  def initialize
    @cards = build_deck  
  end 

  def reset! 
    @cards = []
    @cards = build_deck       
  end 

  def deal  
   @cards.shift  
  end 

  def shuffle
    @cards.shuffle! 
  end 

  private 

  def build_deck 
    [].tap do |cards| 
      SUITS.each do |suit|
        RANKS.each do |rank| 
          cards << Card.new(rank, suit)
        end 
      end 
    end 
  end 
end
