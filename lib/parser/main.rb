module Parser
  class Main
    def initialize(csv, sort_by = :views)
      @csv = csv
      @sort_by = sort_by
    end

    def call
      parse_csv
      serialize_results
      sort_results
    end

    private

    attr_reader :csv, :sort_by

    def parse_csv
      @parsed_csv = csv.flatten.map(&:split)
    end

    def results
      @results ||= {}
    end

    def serialize_results
      @parsed_csv.each do |view|
        key = view[0]

        if results.key?(key)
          results[key][:views] += 1
          unless results[key][:unique_visitors].include?(view[1])
            results[key][:unique_visitors] << view[1]
            results[key][:unique_views] += 1
          end
        else
          results[key] = {
            views: 1,
            unique_views: 1,
            unique_visitors: [].append(view[1])
          }
        end
      end
    end

    def sort_results
      results.sort_by { |_k, v| -v[sort_by] }.to_h
    end
  end
end
