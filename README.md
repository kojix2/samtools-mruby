# samtools-mruby

Use [mruby](https://github.com/mruby/mruby) to evaluate expressions.

## Instllation

```sh
git clone --recurse-submodules https://github.com/kojix2/samtools-mruby
./build.sh
samtools/samtools tanuki # check
```

[Rake](https://github.com/ruby/rake) is required to build mruby.
If you are using [conda to install Ruby](https://dev.to/kojix2/using-ruby-with-conda-1hn), setting the `LD` environment may work.

```sh
rake LD=/usr/bin/gcc MRUBY_CONFIG=$(pwd)/samtools_mruby_build_config.rb -f $(pwd)/mruby/Rakefile
```

## Usage

```sh
samtools/samtools view -E 'puts qname.ljust(13) + seq.green' htslib/test/colons.bam
```

## Contributing

- Fork it
- Pull Request welcome!

## License

MIT License
