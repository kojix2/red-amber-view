# frozen_string_literal: true

require 'red_amber'

module RedAmber
  module View
    DataFrame.include(self)

    def view
      require 'securerandom'
      rand = SecureRandom.hex(10)
      path = "/dev/shm/red-amber-view-#{rand}.arrow"
      while File.exist? path
        path = "/dev/shm/red-amber-view-#{rand}.arrow"
      end
      to_arrow.save(path)
      arrow_table_viewer = File.expand_path('../../exe/arrow_table_view.rb', __dir__)
      pid = spawn("ruby #{arrow_table_viewer} #{path}")
      Process.detach(pid)
    end
  end
end
