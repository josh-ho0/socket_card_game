require './lib/helpers/score_calculator.rb'

class Dealer 
  include ScoreCalculator
  
  attr_reader :name, :hand
  
  def initialize
    @name = "Dealer" 
    @hand = [] 
  end 

  def greeting(collection_of_players)
    players_string = collection_of_players.join(", ")    
    return "Welcome #{players_string} and good luck!! \n Let's get this game started!"
  end 

  def total_score 
    @hand.map { |card_in_hand| score_look_up(card_in_hand.rank) }.sum 
  end 
end 
