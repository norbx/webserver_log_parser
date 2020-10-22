module Parser
  class Serializer
    def initialize(viewer_logs)
      @viewer_logs = viewer_logs
    end

    def call
      serialize_logs
      output_hash
    end

    private

    attr_reader :viewer_logs, :viewer_path, :viewer_ip

    def output_hash
      @output_hash ||= {}
    end

    def serialize_logs
      viewer_logs.each do |viewer_log|
        @viewer_path = viewer_log[0]
        @viewer_ip = viewer_log[1]

        if output_hash.key?(viewer_path)
          increase_views
          increase_unique_views unless viewer_not_unique?
        else
          add_new_view
        end
      end
    end

    def increase_views
      output_hash[viewer_path][:views] += 1
    end

    def viewer_not_unique?
      output_hash[viewer_path][:unique_viewers].include?(viewer_ip)
    end

    def increase_unique_views
      output_hash[viewer_path][:unique_views] += 1
      output_hash[viewer_path][:unique_viewers].append(viewer_ip)
    end

    def add_new_view
      output_hash[viewer_path] = {
        views: 1,
        unique_views: 1,
        unique_viewers: [].append(viewer_ip)
      }
    end
  end
end
