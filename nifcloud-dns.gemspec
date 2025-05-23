# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nifcloud/dns/version'

Gem::Specification.new do |spec|
  spec.name          = 'nifcloud-dns'
  spec.version       = Nifcloud::DNS::VERSION
  spec.authors       = ['kakakikikeke']
  spec.email         = ['cdl.yoshinaka@gmail.com']

  spec.summary       = 'Ruby SDK for nifcloud DNS.'
  spec.description   = 'You can control nifcloud DNS with ruby.'
  spec.homepage      = 'https://github.com/kakakikikeke/nifcloud-dns'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 3.2'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'ruby-hmac'
  spec.add_dependency 'xml-simple'
end
