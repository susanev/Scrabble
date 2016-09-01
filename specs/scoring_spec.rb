require_relative 'spec_helper'
require_relative '../lib/Scrabble'

describe 'Testing scoring_setup_score_chart' do
	it 'must create a hash of value:letter pairs' do
		expect(Scrabble::Scoring.setup_score_chart.must_equal({1=>["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], 2=>["D", "G"], 3=>["B", "C", "M", "P"], 4=>["F", "H", "V", "W", "Y"], 5=>["K"], 6=>["J", "X"], 7=>["Q", "Z"]}))
	end
end

# reference
# describe 'Testing scrabble_score' do
#   it 'It must raise an IllegalArgument if given a non-String' do
#     expect (proc {Scrabble::Scoring.score(2)} ).must_raise ArgumentError
#   end

#   it 'Must return greater than 50 when word is equal to 7 tiles' do
#     expect (Scrabble::Scoring.score("sevenwd")).must_be :>=, 50
#   end

#   it 'Must return score of 8 if "word".' do
#     expect (Scrabble::Scoring.score("word")).must_equal(8)
#   end
# end
