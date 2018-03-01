describe TimeConverter do
  it 'should convert hours to minutes' do
    time = TimeConverter.new
    time.text = '02:30'
    expect(time.to_min).to eq(150)
  end

  it 'should return 0 when text is empty' do
    time = TimeConverter.new
    time.text = ''
    expect(time.to_min).to eq(0)
  end

  it 'should convert minutes to string hour' do
    time = TimeConverter.new 150
    expect(time.to_s).to eq('02:30')
  end
end
