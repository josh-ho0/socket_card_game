# socket_card_game


# Getting Started 
Please go ahead and clone the repo.

1) Once you are on the branch please ```bundle install```
2) ```bundle exec rspec spec``` to run tests 
3) Make sure open multiple tabs within your terminal window 
  - 1 tab will function as your server 
  - 5 other tabs will function as your client since that is the accepted amount of players 

4) In order to run this application:
  - Fire up the server by running ```ruby lib/server.rb``` on your terminal or shell. You should see a message "starting server".
  - The other 5 tabs can run with ```ruby lib/client.rb``` which you will then be prompted to enter a name. Please be sure to enter a unique name  for each client.

5) Let the games begin! Enjoy!



# Known Issues and Improvements, TODOs 
1) Specs can be more robust, need to write test for server and game functionality 
2) Server Handling a ton of logic which can be extracted and maybe handled by the original game class. The server implementation was a bit tricker and more time consuming than I had originally planned
3) Allow players to maybe chat or have some commands that can be understood by the server? Maybe some sort of commands including "help", "show my hand", and other basic quality of life updates
4) This does not work remotely BUT I believe there is a way with my current functionality to implement in that way (maybe related to IP)! (Need to look into this) 
5) No current timeout function or queue functionality. This would require some more research on my part in order to implement. 
6) Restart game functionality not implemented! This can probably be a reuseable method that clears out players hands as well as reruns the core game logic. 
7) Implementation of more complex and robust card point value system. (I was thinking along the lines of increase the point values of J, Q, K, and A by increments of 1 and doing the same for the suits 1-4 value system)
