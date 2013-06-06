# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mail_jack/version"

Gem::Specification.new do |gem|
  gem.authors = ["Peter Philips"]
  gem.description = %q{Add query parameters to links in emails to track click throughs}
  gem.email = ['pete@p373.net']
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/synth/mail_jack'
  gem.name = 'mail_jack'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{Add query parameters to links in emails to track click throughs}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = MailJack::VERSION.dup
end
