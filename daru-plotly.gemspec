# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daru/plotly/version'

Gem::Specification.new do |spec|
  spec.name          = 'daru-plotly'
  spec.version       = Daru::Plotly::VERSION
  spec.authors       = ['Yusuke Sangenya']
  spec.email         = ['longinus.eva@gmail.com']

  spec.summary       = 'Draw graph with daru'
  spec.description   = 'Draw graph with daru'
  spec.homepage      = 'https://github.com/genya0407/daru-plotly'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'daru'
  spec.add_dependency 'rbplotly'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
