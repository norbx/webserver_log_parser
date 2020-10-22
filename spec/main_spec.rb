require 'spec_helper'

RSpec.describe Parser::Main do
  let(:sort_key) { :views }

  let(:logs) do
    [
      ['/help_page/1 126.318.035.038'],
      ['/help_page/1 126.318.035.038'],
      ['/contact 184.123.665.067'],
      ['/home 184.123.665.067']
    ]
  end

  subject { described_class.new(logs, sort_key).call }

  it 'returns a hash' do
    expect(subject).to be_a(Hash)
  end

  it 'returns webpages statistics' do
    help_page = subject['/help_page/1']

    expect(help_page[:views]).to eq(2)
    expect(help_page[:unique_views]).to eq(1)
    expect(help_page[:unique_viewers]).to eq(['126.318.035.038'])
  end

  it 'returns webpages statistics sorted by views' do
    expect(subject).to eq(subject.sort_by { |_k, v| -v[:views] }.to_h)
  end

  context 'when provided with sort key' do
    let(:sort_key) { :unique_views }

    it 'returns webpages statistics sorted by key' do
      expect(subject).to eq(subject.sort_by { |_k, v| -v[:unique_views] }.to_h)
    end
  end
end
