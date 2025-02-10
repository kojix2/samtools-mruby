#!/usr/bin/env bash
git submodule update --init --recursive

# mruby
current_dir=$(dirname "${BASH_SOURCE[0]}")
rake MRUBY_CONFIG=$current_dir/mruby_build_config.rb -f $current_dir/mruby/Rakefile

# htslib
cd htslib
autoreconf -i
./configure
make -j 4
cd ..

# samtools
cd samtools
autoreconf -i
./configure
make -j 4
cd ..

samtools/samtools tanuki
