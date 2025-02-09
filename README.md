# samtools-mruby

[![build](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/samtools-mruby/actions/workflows/build.yml)

Use [mruby](https://github.com/mruby/mruby) to evaluate expressions in [samtools](https://github.com/samtools/samtools)!

![screenshot](https://raw.githubusercontent.com/kojix2/samtools-mruby/screenshot/screenshot-01.png)

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

The `samtools-mruby` project allows you to use mruby expressions to manipulate and analyze BAM files. The available variables include:

- `endpos`: Alignment end position (1-based)
- `flags`: Combined FLAG field
    - `paired` `proper_pair` `unmap` `munmap` `reverse` `mreverse` `read1` `read2` `secondary` `qcfail` `dup` `supplementary`
- `hclen`: Number of hard clipped bases
- `library`: Library (LB header via RG)
- `mapq`: Mapping quality
- `mpos`: Synonym for pnext
- `mrefid`: Mate reference number (0 based)
- `mrname`: Synonym for rnext
- `ncigar`: Number of CIGAR operations
- `pnext`: Mate's alignment position (1-based)
- `pos`: Alignment position (1-based)
- `qlen`: Alignment length: no. query bases
- `qname`: Query name
- `qual`: Quality values (raw, 0-based)
- `refid`: Integer reference number (0 based)
- `rlen`: Alignment length: no. reference bases
- `rname`: Reference name
- `rnext`: Mate's reference name
- `sclen`: Number of soft clipped bases
- `seq`: Sequence
- `tlen`: Template length (insert size)
- `tag`: XX tag value

These variables enable detailed data manipulation and analysis.

### Examples

- **Basic Usage**: Output read name and sequence in green.

  ```sh
  samtools view -E 'puts qname.ljust(13) + seq.green' htslib/test/colons.bam
  ```

- **Pattern Highlighting**: Use regular expressions.

  ```sh
  samtools view -E 'puts qname.ljust(13) + seq.gsub(/CG/, &:red)' htslib/test/colons.bam
  ```

- **Flag Methods**: Access SAM flag information.

  ```sh
  samtools view -E 'puts "#{qname} is paired" if paired?' htslib/test/colons.bam
  ```

- **Tag Access**: Retrieve BAM tags.

  ```sh
  samtools view -E 'puts "NM:#{tag("NM")}" if tag("NM")' htslib/test/colons.bam
  ```

- **Custom Filtering**: Use expressions for filtering.
  ```sh
  samtools view -E 'puts qname if flags & 0x2 != 0' htslib/test/colons.bam
  ```

### Variables

- **Local**: Defined inside expressions, do not persist.
- **Global**: Defined with `$`, persist across records.

Example to count mapped reads:

```sh
samtools view -E '$count ||= 0; $count += 1 unless unmap?; END { puts $count }' htslib/test/colons.bam
```

## Development

The `samtools-mruby` project integrates `mruby` into `samtools`, allowing for enhanced functionality through mruby expressions. This integration includes:

- **Makefile Modifications**: Added support for mruby by including `MRBDIR`, `MRB_CPPFLAGS`, and `MRB_LDFLAGS`. Updated object files list to include `tanuki.o` and `sam_view_mruby.o`.
- **bamtk.c**: Introduced a new `tanuki` command, which displays a tanuki using mruby.
- **sam_view.c**: Added support for evaluating mruby expressions with a new `mruby_expr` field in settings. Integrated mruby initialization and finalization.
- **New Files**:
  - `sam_view_mruby.c`: Implements methods for interacting with BAM records using mruby.
  - `sam_view_mruby.h`: Header file for `sam_view_mruby.c`.
  - `tanuki.c`: Contains the implementation for the `tanuki` command.

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

- MIT License
- This tool was created actively using code generators such as ChatGPT and Copilot.

## Related Projects

- [bcftools-mruby](https://github.com/kojix2/bcftools-mruby)
