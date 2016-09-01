require_relative 'spec_helper'
require_relative '../lib/Scrabble'

describe 'Testing player_initalize' do
	p = Scrabble::Player.new("susan")

	it 'must store the players name' do
		expect(p.name.must_equal("susan"))
	end

	it 'must set plays to an empty array' do
		expect(p.plays.must_equal([]))
	end

	it 'must set total score to zero' do
		expect(p.total_score.must_equal(0))
	end
end

describe 'Testing player_play' do
	p = Scrabble::Player.new("susan")

	it 'must raise Argument Error for non-Strings' do
		expect(proc {p.play(0)} ).must_raise ArgumentError
	end

	p.play("apple")

	it 'must add played word to plays' do
		expect(p.plays.must_equal(["apple"]))
	end

	it 'must updated total score' do
		expect(p.total_score.must_equal(9))
	end
end

describe 'Testing player_won?' do
	it 'must not have won until the player breaks 100' do
		p = Scrabble::Player.new("susan")
		expect(p.won?.must_equal(false))
		p.play("apple")
		p.play("zzzzzzz")
		expect(p.total_score.must_equal(108))
		expect(p.won?.must_equal(true))
		expect(p.play("apple").must_equal(false))
		expect(p.total_score.must_equal(108))
	end
end

describe 'Testing player_highest_scoring_word' do
	it 'must return highest scoring word' do
		p = Scrabble::Player.new("susan")
		p.play("apple")
		expect(p.highest_scoring_word.must_equal("apple"))
		p.play("zzzzzzz")
		expect(p.highest_scoring_word.must_equal("zzzzzzz"))
	end
end

describe 'Testing player_highest_word_score' do
	it 'must return highest word score' do
		p = Scrabble::Player.new("susan")
		p.play("apple")
		expect(p.highest_word_score.must_equal(9))
		p.play("zzzzzzz")
		expect(p.highest_word_score.must_equal(99))
	end
end

# reference
#   it 'Must return greater than 50 when word is equal to 7 tiles' do
#     expect (Scrabble::Scoring.score("sevenwd")).must_be :>=, 50
#   end
# end
