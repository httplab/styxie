# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'styxie/version'

Gem::Specification.new do |s|
  s.name        = 'styxie'
  s.version     = Styxie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Set of helpers to maintain bridge between Server side and Client (JS) side'
  s.email       = 'non.gi.suong@ya.ru, dev@httplab.ru'
  s.homepage    = 'http://github.com/httplab/styxie'
  s.description = s.summary
  s.authors     = ['Yury Kotov', 'Httplab']

  s.has_rdoc = false # disable rdoc generation until we've got more
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
