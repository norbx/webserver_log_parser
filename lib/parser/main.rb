module Parser
  class Main
    def initialize(logs, sort_key = :views, serializer = Parser::Serializer)
      @logs = logs
      @sort_key = sort_key.to_sym
      @serializer = serializer
    end

    def call
      parse_logs
      serialize_logs
      sort_logs
    end

    private

    attr_reader :logs, :sort_key, :serializer

    def parse_logs
      @parsed_logs = logs.flatten.map(&:split)
    end

    def serialize_logs
      @serialized_logs = serializer.new(@parsed_logs).call
    end

    def sort_logs
      @serialized_logs.sort_by { |_k, v| -v[sort_key] }.to_h
    end
  end
end
