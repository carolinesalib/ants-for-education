class TimeConverter
  attr_accessor :min, :text

  def initialize(min = nil, text = nil)
    @min = min
    @text = text
  end

  def to_s
    hours = @min.to_f/60
    hours = hours.to_s.split '.'
    minutes = hours.last
    hours = hours.first
    hours = hours.rjust(2, '0')
    minutes = minutes.to_i*60/100
    minutes = minutes.to_s.ljust(2, '0')
    "#{hours}:#{minutes}"
  end

  def to_min
    time = @text.split ':'
    hours = time.first.to_i
    minutes = time.last.to_i
    hours*60 + minutes
  end
end