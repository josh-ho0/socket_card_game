require 'socket'
require './lib/game'

class Server 
  attr_reader :game

  def initialize(port, ip)
    @server = TCPServer.open(ip, port)
    @connections = Hash.new
    @clients = Hash.new
    @players = Hash.new 
    @connections[:server] = @server
    @connections[:clients] = @clients
    @connections[:players] = @player 
    @game = Game.new 
    run
  end 

  def run
    # one thread per user (else concurrency issues) 
    # user connected and accpeted by server, create new thread  
    loop {
      Thread.start(@server.accept) do |client| 
        # intercept and assign first client response to name variable 
        name = client.gets.chomp.to_sym 

        @connections[:clients].each do |existing_name, _y| 
          if name == existing_name 
            client.puts "This username already exist"
            player_count -= 1 
            Thread.kill self
          end 
        end 

        player = create_player(name.to_s, client) 
                     
        # log name and client information on our server 
        puts "#{name} #{client}"

        #setup key/value pair using the name as the key and newly initialized player object as the value 
        @connections[:clients][name] = player 
        
        #pass player into games players array 
        @game.players << player 
        
        client.puts "Connection established, Welcome to the Game #{player.name.capitalize}!"
        
        # new_user_joined_room_greeting(player.name, client) not working at the moment (idea is to notify all other players that a new player has joined)


        # game triggers once room reaches capacity 
        if @game.players.count == 5 

          #sleep to simulate an actual game-like feel
          sleep 2 

          getting_start_message = "Looks like we are at full capacity for this room. Time to kick things off!"
          all_clients_message(getting_start_message)

          @game.deck.shuffle 

          sleep 2 

          #dealer hits
          dealer_hits_message = "Dealer Hits"
          all_clients_message(dealer_hits_message)
          @game.hit(@game.dealer)

          sleep 2 

          #players hit 
          players_hit_message = "Player(s) Hit"
          all_clients_message(players_hit_message)
          @game.hit_all_player(@game.players)

          sleep 2 

          tally_message = "This might be a close one! Time to tally the score and declare the winner!"
          all_clients_message(tally_message)  

          @game.calculate_score
            

          dealers_score = @game.total_scores["Dealer"]
          players_max_score = @game.total_scores.select { |k, v| k != "Dealer" }.values.max 

          #winner message with score
          all_clients_message(@game.announce_winner(dealers_score, players_max_score))

          #logic to pull name(s) of the winner(s)  
          max_score = [dealers_score, players_max_score].max

          # print score from the server to verify information is correct 
          puts @game.total_scores

          winners = @game.total_scores.select { |key, value| value == max_score }.keys.join(", ")
          winners_message = "Here are your winner(s) - #{winners}"
          all_clients_message(winners_message)
        end 
      end 
    }.join
  end 

  def all_clients
    @game.players.map(&:client)
  end 

  def all_clients_message(message)
    all_clients.each do |client| 
      client.puts "#{message}"
    end  
  end 

  def create_player(client_response, client) 
    Player.new(client_response, client)
  end 

  # def new_user_joined_room_greeting(name, client)
  #   @connections[:clients].each do |other_name, other_client| 
  #     unless other_name == name 
  #       other_client.puts "Looks like #{name.capitalize} has just joined the room!"
  #     end 
  #   end 
  # end 

  # idea behind this method is allow clients to commnuicate with one another
  # ALSO this could be used by our server to listen to certain commands
  def listen_user_messages(username, client)
    loop {
      msg = client.gets.chomp 

      @connections[:clients].each do |other_name, other_client| 
        unless other_name == username 
          other_client.puts "#{username.to_s}: #{msg}"
        end 
      end 
    }
  end 
end 

# # check if port is in use
# # lsof -i TCP:3000 
puts "starting server"
Server.new(3000, "localhost")


