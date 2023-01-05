# RedAmber View

[![Gem Version](https://badge.fury.io/rb/red-amber-view.svg)](https://badge.fury.io/rb/red-amber-view)
[![test](https://github.com/kojix2/red-amber-view/actions/workflows/ci.yml/badge.svg)](https://github.com/kojix2/red-amber-view/actions/workflows/ci.yml)
[![Gitter Chat](https://badges.gitter.im/red-data-tools/en.svg)](https://gitter.im/red-data-tools/en)

R's `View()` for [RedAmber](https://github.com/heronshoes/red_amber).

## Installation

```
gem install red-amber-view
```

## Quick Start

```ruby
require 'red_amber/view'
require 'datasets-arrow'

arrow = Datasets::Penguins.new.to_arrow
penguins = RedAmber::DataFrame.new(arrow)
penguins.view # Return the pid of the child process.
```

![screenshot](https://user-images.githubusercontent.com/5798442/177008662-5a3bb1c2-fbd3-48ea-8f1a-fa3164002a08.png)



## Contributing

RedAmber View is a library under development, so even small improvements like typofix are welcome! Please feel free to send us your pull requests.

## License

MIT
