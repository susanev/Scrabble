module Scrabble
	class Scoring
		attr_accessor :score_chart
		
		def initialize
			@score_chart = {1=>["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], 2=>["D", "G"], 3=>["B", "C", "M", "P"], 4=>["F", "H", "V", "W", "Y"], 5=>["K"], 6=>["J", "X"], 7=>["Q", "Z"]}
		end
	end
end