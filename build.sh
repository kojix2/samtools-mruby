#!/usr/bin/env bash

# mruby
current_dir=$(dirname "${BASH_SOURCE[0]}")
rake MRUBY_CONFIG=$current_dir/mruby_build_config.rb -f $current_dir/mruby/Rakefile

# htslib
cd htslib
git submodule update --init --recursive
autoreconf -i
./configure
make
cd ..

# samtools
cd samtools
git submodule update --init --recursive
autoreconf -i
./configure
make
cd ..

