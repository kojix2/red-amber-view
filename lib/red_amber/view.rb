# frozen_string_literal: true

require 'red_amber'
require_relative 'view/version'

module RedAmber
  module View
    DataFrame.include(self)

    # Invokes a spreadsheet-style data viewer
    def view(title = nil)
      # Linux
      if Dir.exist?('/dev/shm')
        require 'securerandom'
        path = nil
        loop do
          path = "/dev/shm/red-amber-view-#{SecureRandom.hex(8)}.arrow"
          break unless File.exist? path
        end
        begin
          save_succeeded = to_arrow.save(path)
        rescue StandardError => e
          warn e.message
        end
      end

      # When /dev/shm is not available
      unless save_succeeded
        require 'tempfile'
        # The tempfile will be removed by the spawned process.
        tf = Tempfile.create(['red-amber-view', '.arrow'])
        path = tf.path
        save_succeeded = to_arrow.save(path)
      end

      pid = spawn(RbConfig.ruby, arrow_table_viewer, tf.path)
      Process.detach(pid)
    end

    private

    def arrow_table_viewer
      File.expand_path('../../exe/arrow_table_view.rb', __dir__)
    end
  end
end
