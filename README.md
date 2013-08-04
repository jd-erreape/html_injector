# HtmlInjector

A simple class that I'm going to use in other project to inject some custom html into a few already generated HTML files

## Installation

Add this line to your application's Gemfile:

    gem 'html_injector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_injector

## Usage

Simple usage:

```ruby
require 'html_injector'

doc = HtmlInjector.new('<h1 class="test">This is a test</h1><h1>This is the end</h1>')
res = doc.inject_code({
    tag: 'h1',
    css_identifier: 'test',
    node_to_inject: 'h2',
    code_to_inject: 'injected'
})
p res
```

Will output:

```
"<h1 class=\"test\">This is a test</h1><h2>injected</h2><h1>This is the end</h1>"
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
