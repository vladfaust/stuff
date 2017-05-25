lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stuff/version'

Gem::Specification.new do |s|
  s.name     = 'stuff'
  s.version  = Stuff::VERSION
  s.summary  = 'Some shared Ruby code for convenience'
  s.authors  = ['Vlad Faust']
  s.email    = 'mail@vladfaust.com'
  s.homepage = 'https://github.com/vladfaust/stuff'
  s.licenses = ['MIT']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end
