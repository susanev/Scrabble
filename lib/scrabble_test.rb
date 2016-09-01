gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'Scrabble'

class ScrabbleTest < Minitest::Test
	def test_self_score
		assert_equal 9, Scrabble::Scoring.score("apple")
		assert_equal 0, Scrabble::Scoring.score("")
		assert_equal 66, Scrabble::Scoring.score("zebadia")
	end

	def test_self_highest_score_from
		assert_equal "a", Scrabble::Scoring.highest_score_from(["a"])
		assert_equal "ab", Scrabble::Scoring.highest_score_from(["a", "ab"])
		assert_equal "ab", Scrabble::Scoring.highest_score_from(["ab", "ec"])
		assert_equal "zzzzzzz", Scrabble::Scoring.highest_score_from(["ab", "ec", "zzzzzzz"])
		assert_equal "zzzzzzz", Scrabble::Scoring.highest_score_from(["aaaaaaa", "ec", "zzzzzzz"])
		assert_equal "z", Scrabble::Scoring.highest_score_from(["z", "ja", "bba"])
	end
end