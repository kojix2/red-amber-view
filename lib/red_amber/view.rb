# frozen_string_literal: true

require 'red_amber'
require_relative 'view/version'

module RedAmber
  module View
    DataFrame.include(self)

    # Invokes a spreadsheet-style data viewer
    # @param [String] title A title for a viewer window.
    # @return [Integer] The pid of the child process.

    def view(title = 'RedAmber View')
      arrow_path = nil

      # Linux
      if Dir.exist?('/dev/shm')
        require 'securerandom'
        loop do
          arrow_path = "/dev/shm/red-amber-view-#{SecureRandom.hex(8)}.arrow"
          break unless File.exist? arrow_path
        end
        begin
          save_succeeded = to_arrow.save(arrow_path)
        rescue StandardError => e
          warn e.message
        end
      end

      # When /dev/shm is not available
      unless save_succeeded
        require 'tempfile'
        # The tempfile will be removed by the spawned process.
        tf = Tempfile.create(['red-amber-view', '.arrow'])
        arrow_path = tf.path
        save_succeeded = to_arrow.save(arrow_path)
      end

      raise 'Failed to save arrow file' unless save_succeeded

      spawn(RbConfig.ruby, arrow_table_viewer, arrow_path, title)
    end

    private

    def arrow_table_viewer
      File.expand_path('../../exe/arrow_table_view.rb', __dir__)
    end
  end
end
