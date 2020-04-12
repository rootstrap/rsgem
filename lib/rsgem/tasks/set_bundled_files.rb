# frozen_string_literal: true

module RSGem
  module Tasks
    #
    # When the gem is bundled into final users' projects, it only needs to contain the production
    # code. Meaning that specs, docs, configuration files should not be present.
    # This task updates the default `spec.files` configuration in the gemspec to just contain the
    # files:
    #   - LICENSE.txt
    #   - README.md
    #   - lib/**/* (everything inside lib)
    #
    class SetBundledFiles
      attr_reader :context

      def initialize(context:)
        @context = context
      end

      def set
        # Explaining the regular expression:
        # [spec.files][one or more white spaces][=][one or more white spaces][anything until "do"]
        #   [new line][anything until new line]
        # [one or more white spaces][end]
        gemspec.gsub!(
          /spec.files\s+=\s+.+do\n.+\n\s+end/,
          "spec.files = Dir['LICENSE.txt', 'README.md', 'lib/**/*']"
        )
        write

        puts "\tGemspec files config updated"
      end

      private

      def gemspec
        @gemspec ||= File.read(context.gemspec_path)
      end

      def write
        File.open(context.gemspec_path, 'w') do |file|
          file.puts gemspec
        end
      end
    end
  end
end
