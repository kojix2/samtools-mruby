.PHONY: all mruby htslib samtools clean update_submodules

JOBS ?= $(shell echo $${MAKEFLAGS} | sed -n 's/.*-j\([0-9][0-9]*\).*/\1/p')
JOBS ?= 4

all: update_submodules samtools

update_submodules:
	@echo "Updating git submodules..."
	git submodule update --init --recursive

mruby:
	@echo "Building mruby..."
	CONFIG=./mruby_build_config.rb rake -f mruby/Rakefile

htslib:
	@echo "Building htslib..."
	cd htslib && autoreconf -i && ./configure && $(MAKE) -j $(JOBS)

samtools: mruby htslib
	@echo "Building samtools..."
	cd samtools && autoreconf -i && ./configure && $(MAKE) -j $(JOBS)

clean:
	@echo "Cleaning up..."
	cd htslib && make clean
	cd samtools && make clean