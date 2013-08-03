# -*- coding: utf-8 -*-
class Card

	attr_reader :rank, :suit
	
	def initialize(card = [Card.random_rank, Card.random_suit])
		@rank, @suit = card
	end
	
	def self.random_rank
		(2..14).to_a.sample
	end
	
	def self.random_suit
		[:c, :d, :h, :s].sample
	end
	
	def to_s
	 suits = {
		:c => "♣",
		:d => "♦",
		:h => "♥",
		:s => "♠"
	 }
	ranks = {
		2  => " 2",
		3  => " 3",
		4  => " 4",
		5  => " 5",
		6  => " 6",
		7  => " 7",
		8  => " 8",
		9  => " 9",
		10 => "10",
		11 => " J",
		12 => " Q",
		13 => " K",
		14 => " A"
	}
	"#{ranks[self.rank]}#{suits[self.suit]}"
	end



end