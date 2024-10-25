# samtools-mruby

Use [mruby](https://github.com/mruby/mruby) to evaluate expressions.

## Instllation

```sh
git clone --recurse-submodules https://github.com/kojix2/samtools-mruby
./build.sh
```

rake is required to build mruby.

## Usage

```
samtools/samtools view -E 'puts qname.ljust(13) + seq.green' htslib/test/colons.bam
```

## Contributing

- Fork it
- Pull Request welcome!

## License

MIT License
