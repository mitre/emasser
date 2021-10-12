# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run RuboCop'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names', '--extra-details', '--display-style-guide', '--parallel']
end

task default: :test
