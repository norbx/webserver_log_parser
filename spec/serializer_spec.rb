require 'spec_helper'

RSpec.describe Parser::Serializer do
  let(:parsed_logs) { CSV.read('./spec/fixtures/webserver.log').flatten.map(&:split) }

  subject { described_class.new(parsed_logs).call }

  it 'counts views for single path' do
    help_page = subject['/help_page/1']
    page_count = parsed_logs.select { |log| log[0] == '/help_page/1' }.size

    expect(help_page[:views]).to eq(page_count)
  end

  it 'counts unique views for single path' do
    help_page = subject['/help_page/1']
    page_count = parsed_logs.select { |log| log[0] == '/help_page/1' }.uniq.size

    expect(help_page[:unique_views]).to eq(page_count)
  end

  it 'includes every single log' do
    expect(subject.values.map { |h| h[:views] }.sum).to eq(parsed_logs.size)
  end
end
