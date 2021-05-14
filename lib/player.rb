require './lib/helpers/score_calculator.rb'

class Player 
  include ScoreCalculator

  attr_accessor :name, :hand
  attr_reader :client 
  
  def initialize(name, client)
    @name = name 
    @hand = [] 
    @client = client 
  end 

  def total_score 
    @hand.map { |card_in_hand| score_look_up(card_in_hand.rank) }.sum 
  end 
end 

#maybe create a module to calculate points 
