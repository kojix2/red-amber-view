# frozen_string_literal: true

require_relative 'lib/red_amber/view/version'

Gem::Specification.new do |spec|
  spec.name          = 'red-amber-view'
  spec.version       = RedAmber::View::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = 'https://github.com/kojix2/red-amber-view'
  spec.license       = 'MIT'

  spec.files         = Dir['*.{md,txt}', '{lib}/**/*', 'scripts/table-viewer.rb']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'libui'
  spec.add_runtime_dependency 'red_amber'
end
