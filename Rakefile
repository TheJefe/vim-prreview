require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  ENV['GITHUB_TOKEN'] = '123'
  ENV['GITHUB_USERNAME'] = 'test'
end

task :default => :test
