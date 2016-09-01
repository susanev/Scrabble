require_relative 'spec_helper'
require_relative '../lib/Scrabble'

describe 'Testing scoring_setup_score_chart' do
	it 'must create a hash of value:letter pairs' do
		expect(Scrabble::Scoring.setup_score_chart.must_equal({1=>["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], 2=>["D", "G"], 3=>["B", "C", "M", "P"], 4=>["F", "H", "V", "W", "Y"], 5=>["K"], 6=>["J", "X"], 7=>["Q", "Z"]}))
	end
end

describe 'Testing scoring_score' do
	it 'must raise ArgumentError when not passed String' do
		expect (proc {Scrabble::Scoring.score(0)} ).must_raise ArgumentError
	end

	it 'must score the empty string as 0' do
		expect(Scrabble::Scoring.score("").must_equal(0))
	end

	it 'must score a basic word correctly' do
		expect(Scrabble::Scoring.score("apple").must_equal(9))
	end

	it 'must add 50 to a word with 7 letters' do
		expect(Scrabble::Scoring.score("zebadia").must_equal(66))
	end
end

describe 'Testing scoring_highest_score_from' do
	it 'must raise ArgumentError when not passed Array' do
		expect (proc {Scrabble::Scoring.highest_score_from(0)} ).must_raise ArgumentError
	end

	it 'must raise ArgumentError when Array is empty' do
		expect (proc {Scrabble::Scoring.highest_score_from([])} ).must_raise ArgumentError
	end

	it 'must raise ArgumentError when Array does not contain only Strings' do
		expect (proc {Scrabble::Scoring.highest_score_from(["a", "b", 1])} ).must_raise ArgumentError
	end

	it 'must return the item from an array of length 1' do
		expect(Scrabble::Scoring.highest_score_from(["a"]).must_equal("a"))
	end

	it 'must return the highest scoring word from a pair' do
		expect(Scrabble::Scoring.highest_score_from(["a", "ab"]).must_equal("ab"))
	end

	it 'must return the first word in list if tie in score and length' do
		expect(Scrabble::Scoring.highest_score_from(["ab", "ec"]).must_equal("ab"))
	end

	it 'must return seven letter word has highest score' do
		expect(Scrabble::Scoring.highest_score_from(["ab", "ec", "zzzzzzz"]).must_equal("zzzzzzz"))
	end

	it 'must return highest score, if 2 words of 7 letters' do
		expect(Scrabble::Scoring.highest_score_from(["aaaaaaa", "ec", "zzzzzzz"]).must_equal("zzzzzzz"))
	end

	it 'must return shortest length word if tie on scores' do
		expect(Scrabble::Scoring.highest_score_from(["z", "ja", "bba"]).must_equal("z"))
	end
end

# reference
#   it 'Must return greater than 50 when word is equal to 7 tiles' do
#     expect (Scrabble::Scoring.score("sevenwd")).must_be :>=, 50
#   end
# end
