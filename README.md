Playing around with event sourcing/CQRS in rails 4.

Should boot directly with

    bin/rails s

(no rake db setup since we don't have one!)

The infrastructure is mostly based on https://github.com/gregoryyoung/m-r

You'll find your events serialized over in tmp/events.yml if
you're interested.
