require 'benchmark/ips'
require 'rack/file'
require 'rack/test'

TEST_CNT         = (ENV['TEST_CNT'] || 1_000).to_i
ENV["RAILS_ENV"] = ENV['RACK_ENV'] = "production"

'.:lib:test:config'.split(':').each { |x| $: << x }

require 'application'
APP = CodeTriage::Application

APP.initialize!
ActiveRecord::Migrator.migrations_paths = ActiveRecord::Tasks::DatabaseTasks.migrations_paths
ActiveRecord::Migration.verbose = true
ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, nil)

rails_app = APP.instance
@app      = Rack::MockRequest.new(rails_app)


def call_app
  @app.get("/")
end



desc "hits the url TEST_CNT times"
task :test do
  Benchmark.bm { |x|
    x.report("#{TEST_CNT} requests") {
      TEST_CNT.times {
        call_app
      }
    }
  }
end

desc "outputs GC::Profiler.report data while app is called TEST_CNT times"
task :gc do
  GC::Profiler.enable
  TEST_CNT.times { call_app }
  GC::Profiler.report
  GC::Profiler.disable
end

desc "outputs allocated object diff after app is called TEST_CNT times"
task :allocated_objects do
  call_app
  GC.start
  GC.disable
  start = ObjectSpace.count_objects
  TEST_CNT.times { call_app }
  finish = ObjectSpace.count_objects
  GC.enable
  finish.each do |k,v|
    p k => (v - start[k]) / TEST_CNT.to_f
  end
end
