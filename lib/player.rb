require './lib/helpers/score_calculator.rb'

class Player 
  include ScoreCalculator

  attr_reader :client, :name, :hand 
  
  def initialize(name, client)
    @name = name 
    @hand = [] 
    @client = client 
  end 

  def total_score 
    @hand.map { |card_in_hand| score_look_up(card_in_hand.rank) }.sum 
  end 
end 
