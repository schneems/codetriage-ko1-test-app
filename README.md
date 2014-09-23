
## Run Code Triage

### Dependencies

Make sure you have bundler, then install the dependencies:

```shell
$ gem install bundler
$ bundle install
```

Drop current production database:

```
$ RAILS_ENV=production bundle exec rake db:drop
```

Download production database:

```
$ heroku pg:pull DATABASE_URL triage_production -a issuetriage
```

This may take a long time. Make sure that you can have access to https://dashboard-next.heroku.com/apps/issuetriage/metrics/web if not let me know. You only need to do this once.

### Boot application

```
$ RAILS_ENV=production PORT=3000 bundle exec puma -C config/puma.rb
```

## Example request URLs

```
http://localhost:3000/
http://localhost:3000/rails/rails
http://localhost:3000/schneems/wicked
http://localhost:3000/phoenixframework/phoenix?page=2
http://localhost:3000/perldancer/dancer2?page=4
http://localhost:3000/vsclojure/vsclojure
http://localhost:3000/rails-api/active_model_serializers
http://localhost:3000/openlayers/openlayers?page=23
http://localhost:3000/antirez/redis
http://localhost:3000/modsognir/rundown/subscribers
http://localhost:3000/jnunemaker/httparty
```

## Performance Rake Tasks

There are several rake tasks you can run for performance benchmarking

```
$ bundle exec rake -f perf.rake -T
rake allocated_objects  # outputs allocated object diff after app is called TEST_CNT times
rake gc                 # outputs GC::Profiler.report data while app is called TEST_CNT times
rake test               # hits the url TEST_CNT times
```

Run them like this:

```
$ TEST_CNT=100 bundle exec rake -f perf.rake test
```


