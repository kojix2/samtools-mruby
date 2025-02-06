# samtools-mruby

[![build](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml)

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
rake LD=/usr/bin/gcc MRUBY_CONFIG=$(pwd)/mruby_build_config.rb -f $(pwd)/mruby/Rakefile
```

## Usage

```sh
samtools/samtools view -E 'puts qname.ljust(13) + seq.green' htslib/test/colons.bam
```

## Development

1. The mruby directory has not been changed. It was added to a submodule because it is needed to generate libmruby.a.
    1. The following mrbgems are included:
        1. [mruby-terminal-color](https://github.com/buty4649/mruby-terminal-color)
        2. [mruby-regexp-pcre](https://github.com/iij/mruby-regexp-pcre)
2. The htslib directory is also unchanged. This is also useful for samtools builds, so I added it as a submodule.
3. It is preferable to use the latest stable versions of mruby and htslib. These are not modified and can be easily updated.
4. samtools is not origin, but the mruby branch of the kojix2 repository.
5. The tanuki subcommand helps distinguish between ordinary samtools and samtools that incorporate mruby.

## Contributing

- Fork it
- Pull Request welcome!

## License

MIT License
