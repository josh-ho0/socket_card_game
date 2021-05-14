require 'socket'
# require './lib/player'
require './lib/game'
# require './lib/deck'
# require './lib/helpers/score_calculator.rb'

class Server 
  attr_reader :game

  def initialize(port, ip)
    @server = TCPServer.open( ip, port )
    @connections = Hash.new
    # @rooms = Hash.new
    @clients = Hash.new
    @players = Hash.new 
    @connections[:server] = @server
    # @connections[:rooms] = @rooms
    @connections[:clients] = @clients
    @connections[:players] = @player 
    @game = Game.new 
    run

    #initialiers create 3 hash 
    # connection - pool of users 
    # rooms - holds room name and users in each room 
    # clients connected client instances 

    # clients name/username must be unique (can maybe use players name?)
    # connections hash should look like something like...
    # connection: { clients: {client_name: {attribute}}, rooms: { room_name: [clients_names]}}

  end 

  def run
    # one thread per user (else concurrency issues) 
    # user connected and accpeted by server, create new thread and 
    loop {
      Thread.start(@server.accept) do |client| 
        # name_response = client.gets.chomp


        # maybe do something once all 5 players come in... Game.start
        # need to pass entire client so I can send a message to everyone 
        # maybe implement a restart once this is done 
        # puts player_count

        # puts player.inspect

        name = client.gets.chomp.to_sym 


        # update Player Data structure to include client that way we can save the data structure in a hash



        puts "#{name} past this point for client: #{client}"
        @connections[:clients].each do |x, _y| 
          if name == x 
            client.puts "This username already exist"
            player_count -= 1 
            Thread.kill self
          end 
        end 

        player = create_player(name.to_s, client) 
            
        # when player is created, must cache somehow by storing inside, play
        # player_count += 1 




         

        puts "#{name} #{client}"
        #setup key/value pair using the name as the key and newly initialized player object as the value 
        @connections[:clients][name] = player 
        
        #pass player into games players array 
        
        @game.players << player 
        puts @game.players.inspect
        client.puts "Connection established, Welcome to the Game #{player.name.capitalize}!"
        # new_user_joined_room_greeting(player.name, client)


        if @game.players.count == 2 
          # sleep 2 

          getting_start_message = "Looks like we are at full capacity for this room. Time to kick things off!"
          all_clients_message(getting_start_message)

          @game.deck.shuffle 

          # sleep 2 

          #dealer hits
          dealer_hits_message = "Dealer Hits"
          all_clients_message(dealer_hits_message)
          @game.hit(@game.dealer)

          # sleep 2 

          #players hit 
          players_hit_message = "Player(s) Hit"
          all_clients_message(players_hit_message)
          @game.hit_all_player(@game.players)

          # sleep 2 

          tally_message = "This might be a close one! Time to tally the score and declare the winner!"
          all_clients_message(tally_message)  

          @game.calculate_score
          # puts @game.inspect  

          dealers_score = @game.total_scores["Dealer"]
          players_max_score = @game.total_scores.select { |k, v| k != "Dealer" }.values.max 

          puts @game.inspect

          all_clients_message(@game.announce_winner(dealers_score, players_max_score))
          # puts dealers_score 
          # puts players_max_score 
          puts "to be continued"
        end 


        # g = Game.new  
        # once people are connected maybe deal or start the game 
        
        # deal cards to hands 
        # @connections[:clients][:joe].hand << game.deck.deal 
        # puts @connections[:clients][:joe].total_score




        # @connections[:clients][:joe].hand << g.deck.deal
        # puts @connection[:clients][:joe].inspect
        # puts @connections[:clients][:joe].inspect
        # if @connections[:clients][:joe]
        #   @connections[:clients][:joe].hand << ["2", "Heart"]
        #   puts @connections[:client][:joe]
        # end 
        # puts @connections[:clients][:joe].total_score

        # listen_user_messages(name, client)
        # puts "hey" + "#{@connection[:clients]}"        
        # @connection[:clients].each do |x, y|
        #   puts y
        # end 

        # if player.count >= 1 
        #   start_game(players_hash)
        # end 
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

  def new_user_joined_room_greeting(name, client)
    puts name 
    puts client 
    puts @connection.clients 
    @connections[:clients].each do |other_name, other_client| 
      unless other_name == name 
        other_client.puts "Looks like #{name.capitalize} has just joined the room!"
      end 
    end 
  end 

  # two threads should be created, one for reading, one for writing 
  # in this case we are reading so only one thread is fine?
  # allow clients to "write" certain commands? 

  def start_game(players_hash)

  end 

  # how to start server: 
  # Server receives a port which establishes channel between users 
  # Server listens to port for an event and sends a response back to everyone 

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

# # load 'lib/server.rb'
# # server = Server.new("localhost", 3000)
# # server.run 
puts "starting server"
Server.new(3000, "localhost")

# # check if port is in use
# # https://til.hashrocket.com/posts/c42d6a1b3b-check-if-a-port-is-in-use
# # lsof -i TCP:3000 
