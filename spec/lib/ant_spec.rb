require 'rails_helper'

describe Ant do



  describe '#heuristic_information' do
    it 'should return the result of heuristic information to the hard constrains violations quantity' do
      hcv = 4
      expect(subject.heuristic_information(hcv)).to eq(5)
    end
  end
end