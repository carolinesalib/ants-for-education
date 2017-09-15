require 'rails_helper'

RSpec.describe TimeConverter, type: :service do
  describe "#convert" do
    it "convert hours to minutes" do
      time = TimeConverter.new
      time.text = '02:30'
      expect(time.to_min).to eq(150)
    end

    it "convert minutes to string hour" do
      time = TimeConverter.new 150
      expect(time.to_s).to eq('02:30')
    end
  end
end
