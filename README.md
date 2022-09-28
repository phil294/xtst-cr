# xtst-cr

Xtst (X11 extension) bindings for Crystal language.

This is a small extension to [x11-cr by Tamás Szekeres](https://github.com/TamasSzekeres/x11-cr) for libxtst. Currently, it only supports some parts of X Record Extension Library.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  xtst:
    github: phil294/xtst-cr
```

Then run in terminal:
```bash
shards install
```

## Usage


```crystal
require "xtst"

module YourModule
  record = Xtst::RecordExtension.new
end
```

For more details see the doc blocks in the source.

## Documentation

You can generate documentation for yourself:
```shell
crystal doc
```
Then you can open `/docs/index.html` in your browser (untested).

## Contributing

1. Fork it ( https://github.com/phil294/xtst-cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Philip Waritschlager](https://github.com/phil294) - creator, maintainer
