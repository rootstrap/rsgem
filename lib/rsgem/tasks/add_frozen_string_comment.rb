module RSGem
  module Tasks
    class AddFrozenStringComment < Base
      def perform
        [
          context.spec_helper_path,
          context.test_spec_path,
          context.gem_path,
          context.version_file_path
        ].each do |file_path|
          prepend_comment(file_path)
        end
      end

      private

      def frozen_string_magic_comment
        '# frozen_string_literal: true\n\n'
      end

      def prepend_comment(file_path)
        original = File.read(file_path)
        with_comment = original.gsub(/\A/, frozen_string_magic_comment)
        File.write(file_path, with_comment)
      end
    end
  end
end
