require 'Person'
# can require the file or load it in the spec helper 
# https://stackoverflow.com/questions/14501413/rspec-can-only-see-classes-in-the-root-of-my-lib-directory

RSpec.describe Person do 
  person = Person.new("Sam")

  context "when greets method is called" do 
    it "person will greet" do 
      expect(person.say_hello).to eq('hello')
    end 
  end 
end 



# rspec setup 
# mkdir Gemfile >> be sure to add 

# source 'https://rubygems.org'
# gem 'rspec'
# gem 'rake'
# gem 'pry'

# run rspec --init 

# make a lib file, ruby rspec look to find a file in lib 
# add spec file into spec folder (make sure to require file you are using)
