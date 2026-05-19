.PHONY: all init mruby htslib samtools clean mruby-clean distclean update_submodules

JOBS := $(shell echo $${MAKEFLAGS} | sed -n 's/.*-j\([0-9][0-9]*\).*/\1/p')
ifeq ($(JOBS),)
JOBS := 4
endif

all: samtools

init: update_submodules

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
	cd htslib && $(MAKE) clean
	cd samtools && $(MAKE) clean

mruby-clean:
	@echo "Cleaning mruby..."
	CONFIG=./mruby_build_config.rb rake -f mruby/Rakefile clean

distclean: clean mruby-clean
	@echo "Cleaning generated autotools files..."
	rm -rf htslib/autom4te.cache samtools/autom4te.cache
