#!/usr/bin/env bash

current_dir=$(dirname "${BASH_SOURCE[0]}")
rake MRUBY_CONFIG=$current_dir/samtools_mruby_build_config.rb -f $current_dir/mruby/Rakefile
