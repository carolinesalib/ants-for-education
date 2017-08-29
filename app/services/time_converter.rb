class TimeConverter
  def self.min2hour(min)
    min/60 if min
  end

  def self.hour2min(min)
    min*60 if min
  end
end