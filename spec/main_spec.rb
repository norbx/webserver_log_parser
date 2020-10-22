require 'spec_helper'

RSpec.describe Parser::Main do
  let(:file) { File.open('./spec/fixtures/webserver.log') }
  let(:order_by) { nil }

  subject { described_class.new(file, order_by).call }

  it 'returns a list of objects' do
    expect(subject).to be_an(Array)
    expect(subject.first).to be_a(Hash)
  end

  it 'returns webpages statistics' do
    webpage = subject.first

    expect(webpage['path']).to be_present
    expect(webpage['views']).to be_present
    expect(webpage['unique_views']).to be_present
  end

  it 'returns webpages statistics ordered by views' do
    expect(subject).to eq(subject.sort_by { |wp| wp[:views] })
  end

  context 'when provided with key to sort by' do
    let(:order_by) { :unique_views }

    it 'returns webpages statistics ordered by unique views' do
      expect(subject).to eq(subject.sort_by { |wp| wp[:unique_views] })
    end
  end
end
