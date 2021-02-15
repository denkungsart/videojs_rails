# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "videojs_rails/version"

Gem::Specification.new do |s|
  s.name        = "videojs_rails"
  s.version     = VideojsRails::VERSION
  s.authors     = ["Sean Behan"]
  s.email       = ["bseanvt@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{VideoJS plugin for Rails 3.1 Asset Pipeline}
  s.description = %q{HTML5 VideoJS plugin}

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/denkungsart"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  s.rubyforge_project = "videojs_rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
