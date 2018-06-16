## Setup
  ruby -v # 2.4.3

  rake db:setup
  
## Development
 ./node_modules/webpack/bin/webpack.js --config ./webpack.config.js --watch

## Deploy
  heroku addons:create bucketeer:hobbyist 


## Explanation of column names
  Coverage.cost_in_cents = the amount they need to keep in reserve per coverage
  Coverage.fees_in_cents = the amount they need to pay fsa for that coverage

  Addons.cost_in_cents = Same as above
  Addons.fees_in_cents = Same as above

  Contract.price_in_cents = Price they sold the contract to the customer to
