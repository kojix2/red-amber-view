# frozen_string_literal: true

require_relative 'lib/red_amber/view/version'

Gem::Specification.new do |spec|
  spec.name          = 'red-amber-view'
  spec.version       = RedAmber::View::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'A Data Viewer for RedAmber'
  spec.description   = 'A Data Viewer for RedAmber. Opens a window and displays a spreadsheet-like table.'
  spec.homepage      = 'https://github.com/kojix2/red-amber-view'
  spec.license       = 'MIT'

  spec.files         = Dir['*.{md,txt}', '{lib}/**/*', 'exe/arrow_table_view.rb']
  # spec.bindir      = 'exe'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'libui'
  spec.add_runtime_dependency 'red_amber'
  spec.add_runtime_dependency 'red-arrow'
end
