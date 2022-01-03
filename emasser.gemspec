# frozen_string_literal: true

require_relative 'lib/emasser/version'

Gem::Specification.new do |spec|
  spec.name = 'emasser'
  spec.version = Emasser::VERSION
  spec.authors = ['Amndeep Singh Mann', 'George Dias', 'Kyle Fagan', 'Robert Clark', 'Aaron Lippold']
  spec.email = ['saf@mitre.org']
  spec.licenses = ['Nonstandard']

  spec.summary = 'Provide an automated capability for invoving eMASS API endpoints'
  spec.description = 'emasser can be used as a gem or used from the command line to access eMASS via thei API.'
  spec.homepage = 'https://saf.mitre.org'
  spec.required_ruby_version = Gem::Requirement.new('~> 2.7')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_runtime_dependency 'activesupport', '~> 6.1.4.4'
  spec.add_runtime_dependency 'colorize', '~> 0.8.1'
  spec.add_runtime_dependency 'dotenv', '~> 2.7.6'
  spec.add_runtime_dependency 'rubyzip', '~> 2.3.2'
  spec.add_runtime_dependency 'swagger_client', '~> 1.0.0'

  spec.add_development_dependency 'bundler', '~> 2.2.29'
  spec.add_development_dependency 'bundler-audit', '~> 0.9.0.1'
  spec.add_development_dependency 'byebug', '~> 11.1.3'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'yaml', '~> 0.2.0'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rubocop', '~> 1.24.0'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.17.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.13.0'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
end
