module Scrabble
	class Scoring
		attr_accessor :score_chart
		
		def initialize
			setup_score_chart
		end

		def self.setup_score_chart
			@score_chart = {1=>["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], 2=>["D", "G"], 3=>["B", "C", "M", "P"], 4=>["F", "H", "V", "W", "Y"], 5=>["K"], 6=>["J", "X"], 7=>["Q", "Z"]}
		end

		def self.score(word)
			if word.class != String
				raise ArgumentError.new("Must pass a string")
			end

			setup_score_chart
			score = 0
			word.length == 7 ? score = 50 : score = 0
			word = word.upcase

			word.each_char do |x|
				@score_chart.values.each do |letters|
					if letters.include?(x)
						score+=@score_chart.key(letters)
						break
					end
				end
			end

			return score
		end

		def self.highest_score_from(words)
			if words.class != Array 
				raise ArgumentError.new('Must pass an array')
			elsif words.length == 0
				raise ArgumentError.new('Array must have values')
			else
				words.each do |word|
					if word.class != String
						raise ArgumentError.new('Array must contain String values only')
					end
				end
			end

			scores = {}

			words.each do |word|
				scores[word] = score(word)
			end

			max_v = scores.values.max
			max_k = scores.key(scores.values.max)

			scores.delete(max_k)

			tie = {max_k => max_v}
			min_tiles = max_k.length
			while max_v == scores.values.max 
				max_v = scores.values.max
				max_k = scores.key(scores.values.max)

				scores.delete(max_k)

				tie[max_k] = max_v

				if max_k.length < min_tiles 
					min_tiles = max_k.length
				end
			end

			# fewest tiles and first in words
			words.each do |word|
				if tie.key?(word) && word.length == min_tiles
					return word
				end
			end
		end
	end

	class Player
		attr_accessor :name, :plays, :total_score

		def initialize (name)
			@name = name
			@plays = []
			@total_score = 0
		end

		def play(word)
			@plays << word
			if won?
				return false
			else
				value = Scrabble::Scoring.score(word)
				@total_score+=value
				return value
			end
		end

		def won?
			return @total_score > 100
		end

		def highest_scoring_word
			return Scrabble::Scoring.highest_score_from(@plays)
		end

		def highest_word_score
			return Scrabble::Scoring.score(Scrabble::Scoring.highest_score_from(@plays))
		end
	end
end













