require 'hanoi.rb'

describe "Hanoi" do

  let(:game) { Hanoi.new }

  before(:each) do
     #game.play
  end

  describe "#board" do
    it "starts the game with all discs on one pile" do
      game.board[0].should == [0, 1, 2]
      game.board[1].should be_empty
      game.board[2].should be_empty
    end
    it "correctly models game state" do
      game.move(0, 2)
      game.move(0, 1)
      game.board[0].should == [2]
      game.board[1].should == [1]
      game.board[2].should == [0]
    end

  end
  describe "#move" do
    it "doesn't let you move bigger discs on top of smaller discs" do
      game.move(0, 2)
      expect { game.move(0, 2) }.to raise_error(InvalidMoveError)
    end
    it "lets you move smaller discs on top of larger discs" do
      game.move(0, 2)
      expect { game.move(0, 1) }.to_not raise_error
    end

  end
  describe "#won?" do
    it "tells you when you've won" do
      game.move(0, 2)
      game.move(0, 1)
      game.move(2, 1)
      game.move(0, 2)
      game.move(1, 0)
      game.move(1, 2)
      game.move(0, 2)
      game.should be_won
    end
  end
end


