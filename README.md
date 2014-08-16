# Burlesque message queue client

Ruby wrapper over [Burlesque message queue](https://github.com/KosyanMedia/burlesque) API

## Installation
```
gem install burlesque-client
```

## Configuration
Client defaults are the same as Burlesque server defaults.
If you're using non-standard settings, you can configure client to use them instead.

```ruby
Burlesque.configure do |c|
  c.host = '10.10.5.155'
  c.port = 4402
  c.timeout = 30
end
```

## Usage

### Publish
```ruby
require 'burlesque'

client = Burlesque::Client.new
queue = 'urgent'
msg = 'Process this message as soon as possible!'

if client.publish(queue, msg)
  puts 'Message successfully published!'
else
  puts 'Failed to publish message'
end
```

### Subscribe
```ruby
require 'burlesque'

client = Burlesque::Client.new

res = client.subscribe('urgent', 'someday', 'never')
if res.nil?
  puts 'No messages'
else
  puts "Message from queue #{res[:queue]}:"
  puts res[:message]
end
```

### Status
```ruby
require 'json'
require 'burlesque'

client = Burlesque::Client.new
puts JSON.pretty_generate(client.status)
```

### Debug
```ruby
require 'json'
require 'burlesque'

client = Burlesque::Client.new
puts JSON.pretty_generate(client.debug)
```

## CLI
```
$ bsq --help

Usage:
    Publish:
        $ bsq pub urgent "Process this message as soon as possible!"
        or
        $ cat urgent-183.txt | bsq pub urgent
    Subscribe:
        $ bsq sub urgent > urgent-184.txt
    Status:
        $ bsq status
    Debug:
        $ bsq debug

Options:
    -h, --host [HOST]                Burlesque host
    -p, --port [PORT]                Burlesque port
    -t, --timeout [TIMEOUT]          Subscription timeout
    -v, --version                    Display Burlesque Ruby client version
        --help                       Display this help message
```

## Licence

[MIT](https://github.com/KosyanMedia/burlesque-ruby/blob/master/LICENCE.txt)