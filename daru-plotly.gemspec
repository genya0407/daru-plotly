# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daru/version'

Gem::Specification.new do |spec|
  spec.name          = "daru-ploly"
  spec.version       = Daru::Plotly::VERSION
  spec.authors       = ["Yusuke Sangenya"]
  spec.email         = ["longinus.eva@gmail.com"]

  spec.summary       = %q{Plot Daru's DataFrame with plotly.}
  spec.description   = %q{Plot Daru's DataFrame with plotly.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "daru"
  spec.add_dependency "rbplotly"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
