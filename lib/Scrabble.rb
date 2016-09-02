module Scrabble
	class Scoring
		attr_accessor :score_chart
		
		def initialize
			setup_score_chart
		end

		def self.setup_score_chart
			@score_chart = {1=>%w{A E I O U L N R S T}, 2=>%w{D G}, 3=>%w{B C M P}, 4=>%w{F H V W Y}, 5=>%w{K}, 6=>%w{J X}, 7=>%w{Q Z}}
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
		attr_accessor :name, :plays, :total_score, :tiles

		def initialize (name)
			@name = name
			@plays = []
			@total_score = 0
			@tiles = []
		end

		def draw_tiles(tile_bag)
			@tiles << tile_bag.draw_tiles(7-@tiles.length)
			@tiles.flatten!
		end

		def play(word)
			if(word.class != String)
				raise ArgumentError.new("plays must be Strings only")
			end

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

	class TileBag
		attr_accessor :default_tiles

		def initialize
			@default_tiles = {A:9, B:2, C:2, D:4, E:12, F:2, G:3, H:2, I:9, J:1, K:1, L:4, M:2, N:6, O:8, P:2, Q:1, R:6, S:4, T:6, U:4, V:2, W:2, X:1, Y:2, Z:1}
		end

		def draw_tiles(num)
			if num > tiles_remaining
				raise ArgumentError.new("You do not have enough tiles left")
			end

			tiles = []

			num.times do 
				k,v = @default_tiles.to_a.sample(1)[0]
	
				tiles << k

				if(v == 1)
					@default_tiles.delete(k)
				else
					@default_tiles[k]-=1
				end
			end

			return tiles
		end

		def tiles_remaining
			count = 0
			@default_tiles.each do |k,v|
				count+=v
			end

			return count
		end
	end
end














