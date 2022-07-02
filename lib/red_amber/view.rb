# frozen_string_literal: true

require 'red_amber'

module RedAmber
  module View
    DataFrame.include(self)

    def view
      path = '/dev/shm/red-amber-view.arrow'
      to_arrow.save(path)
      tableviewer = File.expand_path('../../scripts/table-viewer.rb', __dir__)
      pid = spawn("ruby #{tableviewer} #{path}")
      Process.detach(pid)
    end
  end
end
