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

	def test_player_init
		p = Scrabble::Player.new("susan")
		assert_equal "susan", p.name
		assert_equal [], p.plays
		assert_equal 0, p.total_score
	end

	def test_player_play
		p = Scrabble::Player.new("susan")
		p.play("apple")
		assert_equal ["apple"], p.plays
		assert_equal 9, p.total_score
	end

	def test_player_won?
		p = Scrabble::Player.new("susan")
		assert_equal false, p.won?
		p.play("apple")
		p.play("zzzzzzz")
		assert_equal 108, p.total_score
		assert_equal true, p.won?
		assert_equal false, p.play("apple")
		assert_equal 108, p.total_score
	end

	def test_player_highest_scoring_word
		p = Scrabble::Player.new("susan")
		p.play("apple")
		p.play("zzzzzzz")
		assert_equal "zzzzzzz", p.highest_scoring_word
	end

	def test_player_highest_word_score
		p = Scrabble::Player.new("susan")
		p.play("apple")
		p.play("zzzzzzz")
		assert_equal 99, p.highest_word_score
	end
end