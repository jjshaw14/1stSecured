## Setup
  ruby -v # 2.4.3

  rake db:setup
  
## Development
 ./node_modules/webpack/bin/webpack.js --config ./webpack.config.js --watch

## Deploy
  heroku addons:create bucketeer:hobbyist 
