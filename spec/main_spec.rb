require 'spec_helper'

RSpec.describe Parser::Main do
  let(:csv) do
    [
      ['/help_page/1 126.318.035.038'],
      ['/help_page/1 126.318.035.038'],
      ['/contact 184.123.665.067'],
      ['/home 184.123.665.067']
    ]
  end
  let(:sort_by) { :views }

  subject { described_class.new(csv, sort_by).call }

  it 'returns a list of objects' do
    expect(subject).to be_a(Hash)
  end

  it 'returns webpages statistics' do
    webpage = subject['/help_page/1']

    expect(webpage[:views]).to eq(2)
    expect(webpage[:unique_views]).to eq(1)
    expect(webpage[:unique_visitors]).to eq(['126.318.035.038'])
  end

  it 'returns webpages statistics sorted by views' do
    expect(subject).to eq(subject.sort_by { |_k, v| -v[:views] }.to_h)
  end

  context 'when provided with key to sort by' do
    let(:sort_by) { :unique_views }

    it 'returns webpages statistics sorted by unique views' do
      expect(subject).to eq(subject.sort_by { |_k, v| -v[:unique_views] }.to_h)
    end
  end
end
