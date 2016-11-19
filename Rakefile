require 'rspec/core/rake_task'
require 'cookstyle'
require 'rubocop/rake_task'
require 'foodcritic'
require 'mixlib/shellout'
require 'kitchen/rake_tasks'

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options << '--display-cop-names'
  end

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: ['~FC005']
    }
  end
end

desc 'Run all style checks'
task style: %w(style:chef style:ruby)

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |r|
  r.pattern = 'spec/**/*_spec.rb'
end

# Default
task default: %w(style spec)
