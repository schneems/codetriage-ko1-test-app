
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

## Next

Let me know what else you need. Since this issue only shows up over time, I don't know what kind of a single benchmark we can run. If we figure this out, I can put some more work into the issue.
