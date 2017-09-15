require 'rails_helper'

RSpec.describe TimeConverter, type: :service do
  describe "#convert" do
    it "convert hours to minutes" do
      minutes = TimeConverter.hour2min '02:30'
      expect(minutes).to eq(150)
    end

    it "convert minutes to string hour" do
      time = TimeConverter.min2hour 150
      expect(time).to eq('02:30')
    end
  end
end
