# samtools-mruby

[![build](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml)

Use [mruby](https://github.com/mruby/mruby) to evaluate expressions in [samtools](https://github.com/samtools/samtools)!

## Installation

```sh
git clone --recurse-submodules https://github.com/kojix2/samtools-mruby
./build.sh
samtools/samtools tanuki # check if it works
```

```
　　　　__,-─-､__
　　　（〆-─-ヽ)
　　　 （ ´・ω・｀ ）
　　　/ 　,r‐‐‐､ヽ
　 　 し　ｌ　 x　）J
　　　_.'､ ヽ　 ノ.人
　(_((__,ノＵ´U. (酒)

　Tanuki in mruby (3.3.0)
```

[Rake](https://github.com/ruby/rake) is required to build mruby.
If you are using [conda to install Ruby](https://dev.to/kojix2/using-ruby-with-conda-1hn), set the `LD` environment variable:

```sh
rake LD=/usr/bin/gcc MRUBY_CONFIG=$(pwd)/mruby_build_config.rb -f $(pwd)/mruby/Rakefile
```

## Usage

Output the read name and sequence of the BAM file in green:

```sh
samtools view -E 'puts qname.ljust(13) + seq.green' htslib/test/colons.bam
```

Highlight specific patterns using **regular expressions**:

```sh
samtools view -E 'puts qname.ljust(13) + seq.gsub(/CG/, &:red)' htslib/test/colons.bam
```

![screenshot](https://raw.githubusercontent.com/kojix2/samtools-mruby/screenshot/screenshot-01.png)

### Working with Flags

You can access the SAM flag information using the `flags` method or specific flag methods:

```sh
samtools view -E 'puts "#{qname} is paired" if paired?' htslib/test/colons.bam
```

Available flag methods:

- `flags`: Returns the combined FLAG field (integer).
- `paired?`: True if the read is part of a pair.
- `proper_pair?`: Properly paired.
- `unmap?`: Read is unmapped.
- `munmap?`: Mate is unmapped.
- `reverse?`: Read is mapped to the reverse strand.
- `mreverse?`: Mate is mapped to the reverse strand.
- `read1?`: First read in a pair.
- `read2?`: Second read in a pair.
- `secondary?`: Secondary alignment.
- `qcfail?`: QC failure.
- `dup?`: Duplicate.
- `supplementary?`: Supplementary alignment.

It works without the `?`

```sh
samtools view -E 'puts "#{qname} is paired" if paired' htslib/test/colons.bam
```

Example to filter proper pairs:

```sh
samtools view -E 'puts qname if proper_pair?' htslib/test/colons.bam
```

### Using Tags

Access BAM tags easily:

```sh
samtools view -E 'puts "NM:#{tag("NM")}" if tag("NM")' htslib/test/colons.bam
```

## Local vs Global Variables

- **Local Variables**: Defined inside expressions. Their values do **NOT** persist across records.
- **Global Variables**: Defined with `$` (e.g., `$count = 0`). These **persist** across record iterations.

Example to count mapped reads:

```sh
samtools view -E '$count ||= 0; $count += 1 unless unmap?; END { puts $count }' htslib/test/colons.bam
```

## Development

To see changes made to the original samtools repository:

```sh
git -C samtools diff origin/develop...origin/mruby
```

- The `mruby` and `htslib` directories are submodules.
  - [mruby-terminal-color](https://github.com/buty4649/mruby-terminal-color)
  - [mruby-regexp-pcre](https://github.com/iij/mruby-regexp-pcre)
- `samtools` is based on the `mruby` branch of the kojix2 repository.
- The `tanuki` subcommand distinguishes between standard and mruby-enhanced samtools.

## Contributing

Send pull requests to the `mruby` branch of my [samtools repository](https://github.com/kojix2/samtools).

## License

MIT License

## Related Projects

- [bcftools-mruby](https://github.com/kojix2/bcftools-mruby)
