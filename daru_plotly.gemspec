# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "daru_plotly"
  spec.version       = Daru::Plotly::VERSION
  spec.authors       = ["Yusuke Sangenya"]
  spec.email         = ["longinus.eva@gmail.com"]

  spec.summary       = %q{Plot Daru's DataFrame with plotly.}
  spec.description   = %q{Plot Daru's DataFrame with plotly.}
  spec.homepage      = "https://github.com/genya0407/daru_plotly"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "daru"
  spec.add_dependency "rbplotly"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rbczmq"
  spec.add_development_dependency "iruby"
  spec.add_development_dependency "spreadsheet"
  spec.add_development_dependency "nyaplot"
  spec.add_development_dependency "gruff"

  spec.post_install_message = <<-MESSAGE
  !    The 'daru_plotly' gem has been deprecated and has been replaced by 'daru-plotly'.
  !    See: https://rubygems.org/gems/daru-plotly
  !    And: https://github.com/genya0407/daru-plotly
  MESSAGE
end
