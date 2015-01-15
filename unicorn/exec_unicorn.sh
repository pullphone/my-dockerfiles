#!/bin/bash

source /etc/profile
cd /var/rack
/.rbenv/shims/bundle install --path=/var/rack/vendor/bundle
/.rbenv/shims/bundle exec unicorn -c /var/rack/unicorn.rb -E development

