# Walmart

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'walmart'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install walmart

## Usage

Find Offer
```ruby
Walmart::Offer.find(sellerSKU)
```

Create Offer
```ruby
Walmart::Offer.create! {}
```

Update Price
```ruby
Walmart::Offer.new(SellerSKU).update_price! price, listPrice: list_price
```

Update Stock
```ruby
Walmart::Offer.new(SellerSKU).update_quantity! stock_total
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/walmart-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
