require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/test_*.rb'
  test.verbose = true
end

namespace :test do
  desc "Prepares the test rails apps: Install bundle and migrate sqlite db"
  task :prepare do
    Dir['test/rails*'].each do |dir|
      Dir.chdir(dir) do
        system "bundle install" if `bundle check` and not $?.success?
        system "rake db:migrate"
        system "rake db:test:clone_structure"
      end
    end
  end
end


task :test => :"test:prepare"
task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
