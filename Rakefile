require 'rake/testtask'

Rake::TestTask.new do |t|
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start

  t.test_files = FileList['test/*_test.rb']
end

task default: :test
