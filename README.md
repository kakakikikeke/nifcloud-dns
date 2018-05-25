# Nifcloud::DNS

You can control nifcloud DNS with ruby.

## Installation

```
$ gem install nifcloud-dns
```

## Usage

* Create A record.

```
record = Nifcloud::DNS::Record.new 'your-domain.com'
res = record.add('www1', 'A', '192.168.100.1')
```

* List records.

```
record = Nifcloud::DNS::Record.new 'your-domain.com'
res = record.list
```

* Delete A record.

```
record = Nifcloud::DNS::Record.new 'your-domain.com'
res = record.del('www1', 'A', '192.168.100.1')
```

* List zones.

```
zone = Nifcloud::DNS::Zone.new
res = zone.list
```

## Test

Please register your test domain (`yourdomain.com`) into nifcloud DNS before starting the test.

* export ACCESS_KEY=xxx
* export SECRET_KEY=xxx
* export ZONE=yourdomain.com
* bundle exec rake spec

## Development

1. Setup
  * bundle install --path vendor
2. Fix or write codes ex) lib/nifcloud/dns/record.rb
3. Check features by repl
  * bundle console
4. Build a gem
  * bundle exec rake build

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakakikikeke/nifcloud-dns.
