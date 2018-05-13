class TimeLimitError < StandardError
  def to_s
    'Time limit was been reached'
  end
end