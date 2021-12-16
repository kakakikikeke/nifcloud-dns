
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nifcloud/dns/version"

Gem::Specification.new do |spec|
  spec.name          = "nifcloud-dns"
  spec.version       = Nifcloud::DNS::VERSION
  spec.authors       = ["kakakikikeke"]
  spec.email         = ["cdl.yoshinaka@gmail.com"]

  spec.summary       = %q{Ruby SDK for nifcloud DNS.}
  spec.description   = %q{You can control nifcloud DNS with ruby.}
  spec.homepage      = "https://github.com/kakakikikeke/nifcloud-dns"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_runtime_dependency "ruby-hmac"
  spec.add_runtime_dependency "xml-simple"
end
