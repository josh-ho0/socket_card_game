require './lib/dealer'
require './lib/deck'
require './lib/player'

class Game 
  attr_accessor :deck, :players, :dealer, :total_scores

  def initialize
    @deck = Deck.new 
    @players = [] 
    @dealer = Dealer.new  
    @total_scores = {} 
  end 

  # def game_start 
  #   # ready_the_players 
  #   deck.shuffle

  #   puts dealer.greeting(players)

  #   puts "Dealer Hits!"

  #   hit(dealer)

  #   puts "Players Each Hit!"

  #   hit_all_player(players) 
  
  #   puts "This might be a close one! Time to tally the score and declare the winner!"
    
  #   determine_winner
  # end 

  def hit(player)
    puts "#{player.name} was dealt two cards!" 

    2.times { player.hand << deck.deal }
  end 

  def hit_all_player(players)
    players.each do |player| 
      hit(player)
    end 
  end 

  def total_and_record_dealers_score  
    total_scores[dealer.name] = dealer.total_score
  end 

  def total_and_record_players_score(players)
    players.each do |player| 
      total_scores[player.name] = player.total_score 
    end 
  end 

  def calculate_score  
    total_and_record_dealers_score
    total_and_record_players_score(players)

    # dealers_score = total_scores["Dealer"]
    # players_max_score = total_scores.select { |k, v| k != "Dealer" }


    # announce_winner(dealers_score, players_max_score)
    # total_scores.select { |key, value| value == players_max_score }
  
  end 

  def announce_winner(dealers_score, players_max_score)
    # player_names = total_scores.select { |key, value| value == player_max_score }.join(", ")

    # additional_message = multiple_winners?(player_max_score) ? "#{player_names} #{win}"

    if players_max_score == dealers_score
      return "Uh-Oh looks like a tie between #{dealer.name} and players with a score of #{players_max_score} "
    elsif players_max_score > dealers_score
      return "Looks like players win this round with a score of #{players_max_score} to #{dealers_score}! "
    else 
      return "Awww looks like the dealer wins with a score of #{dealers_score} to #{players_max_score}. Rememeber the Dealer ALWAYS wins, better luck next time!" 
    end 
  end 

  # def multiple_winners?(player_max_score)
  #   total_scores.select { |key, value| value == player_max_score }.count > 1  
  # end 

  private 

  def ready_the_players
    player_count = 1 
    while player_count <= 5
      @players << Player.new("Player_#{player_count}")
      player_count += 1
    end   
  end 
end 
