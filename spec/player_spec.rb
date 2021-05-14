require 'Player'
# can require the file or load it in the spec helper 
# https://stackoverflow.com/questions/14501413/rspec-can-only-see-classes-in-the-root-of-my-lib-directory

RSpec.describe Player do 
  player = Player.new("Sam", "Dummy Client for Now")

  context "when new player is initialized" do 
    it "has a name" do 
      expect(player.name).to eq('Sam')
    end 

    it "has a client" do 
      expect(player.client).to eq("Dummy Client for Now")
    end 

    it "has an empty hand" do 
      expect(player.hand).to be_empty
    end 
  end 
end 
