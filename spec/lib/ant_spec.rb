require 'rails_helper'

describe Ant do

  describe '#initialize' do
    it 'should contains a solution' do
      expect(subject.solution).to be_a(Solution)
    end
  end
end