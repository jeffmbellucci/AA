require 'rspec'
require 'card.rb'

describe 'Card' do 
  
  let(:card) { Card.new() }
  
  it 'has a rank' do
    card.rank.should be_between(1, 14)
  end

  it 'has a suit' do 
    [:d, :h, :s, :c].include?(card.suit).should == true 
  end
  
end