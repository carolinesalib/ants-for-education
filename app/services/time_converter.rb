class TimeConverter
  def self.min2hour(min)
    hours = min.to_f/60
    hours = hours.to_s.split '.'
    minutes = hours.last
    hours = hours.first
    hours = hours.rjust(2, '0')
    minutes = minutes.to_i*60/100
    minutes = minutes.to_s.ljust(2, '0')
    "#{hours}:#{minutes}"
  end

  def self.hour2min(text_hour)
    text_hour = text_hour.split ':'
    hours = text_hour.first.to_i
    minutes = text_hour.last.to_i
    hours*60 + minutes
  end
end