# Sendowl

Ruby client for Send Owl. Check it out at [SendOwl](https://www.sendowl.com/)

## Getting Started

### Installation

Add this line to your application's Gemfile:

```ruby
gem "sendowl"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendowl

### Configure your API key and API secret

You can set your API key/secret in Ruby:

```ruby
Sendowl.api_key        = "YOUR_API_KEY"
Sendowl.api_secret     = "YOUR_API_SECRET"
```

or set the environment variable _SENDOWL\_API\_KEY_ and _SENDOWL\_API\_SECRET_ (**recommended**)

## Usage

So far, one single feature from the whole platform is available: Licenses.

### Licenses

#### Validating a License Key

To validate a License Key, all you need to do is the following:

```ruby
Sendowl::License.new(product_id: 1, key: "ABCD-1234-EFGH-5678").valid?
```

This returns either an instance of Sendowl::License
```ruby
  #<Sendowl::License:0x00007ff96efe2008 @id=11111111, @order_id=22222222, @product_id=1, @key="ABCD-1234-EFGH-5678", @order_refunded=false>
```
or simply `nil`

## Contributing

### TODO

As you may have noticed, this gem is in construction and most features are not yet
available. So support to Products, Bundles, Subscriptions, Drip Items etc are
missing and I welcome any effort to help supporting those features.

This gem also needs specs and, since it's been brought to life in a hurry
because I only needed one feature of it, has no open source CI configured nor
anything that remotely guarantees its stability. So help in making it stable is
also welcome.

### Bugs and Issues

Bug reports and pull requests are welcome on GitHub at https://github.com/tdtadeu/sendowl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sendowl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tdtadeu/sendowl/blob/master/CODE_OF_CONDUCT.md).
