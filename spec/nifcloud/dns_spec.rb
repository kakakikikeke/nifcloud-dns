# frozen_string_literal: true

RSpec.describe Nifcloud::DNS do # rubocop:disable Metrics/BlockLength
  before(:all) do
    @record = Nifcloud::DNS::Record.new ENV.fetch('ZONE', nil)
    @zone = Nifcloud::DNS::Zone.new
    @name = 'www1'
  end

  it 'has a version number' do
    expect(Nifcloud::DNS::VERSION).not_to be nil
  end

  it 'list zones' do
    res = @zone.list
    target = res.body['HostedZones'].first['HostedZone'].map do |rrs|
      rrs['Name'].first if rrs['Name'].first == ENV['ZONE']
    end.compact.first
    expect(res.code).to eq('200')
    expect(target).to eq(ENV.fetch('ZONE', nil))
  end

  it 'show zone' do
    res = @zone.show ENV.fetch('ZONE', nil)
    expect(res.code).to eq('200')
  end

  it 'create a record' do
    res = @record.add(@name, 'A', '192.168.100.1')
    expect(res.code).to eq('200')
  end

  it 'list records' do
    res = @record.list
    target = res.body['ResourceRecordSets'].first['ResourceRecordSet'].map do |rrs|
      rrs['Name'].first if rrs['Name'].first == "#{@name}.#{ENV.fetch('ZONE', nil)}"
    end.compact.first
    expect(res.code).to eq('200')
    expect(target).to eq("#{@name}.#{ENV.fetch('ZONE', nil)}")
  end

  it 'delete a record' do
    res = @record.del(@name, 'A', '192.168.100.1')
    expect(res.code).to eq('200')
  end
end
