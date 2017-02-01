PERL5 ?= $(shell which perl)
PERL6 ?= $(shell which perl6)
datafile := expr.txt
time := $(shell which time)

# 5k.txt (in seconds):
#   2.462 (PRD) vs 1.662 (RG) (perl 5.16.3)
#   2.457 (PRD) vs 1.739 (RG) (perl 5.18.4)
#   1.436 (PRD) vs 1.556 (RG) (perl 5.20.2)
# 1.755 2.629 2.472

bench: $(datafile) info pegex prd perl6 fanlang

.PHONY: info
info:
	-@uname -a
	-@sysctl -n machdep.cpu.brand_string || \
	    grep 'model name' /proc/cpuinfo|head -n1|sed 's/model name\s*: //'
	@echo
	ls -lh $(datafile)
	@echo

	@echo === Perl `$(PERL5) -e 'print $$^V'` eval
	sed 's/\^/**/g' $(datafile) > pl-$(datafile)
	$(time) $(PERL5) -e 'my $$a = do { local $$/; <> }; eval "print q{Result: }, $$a, qq{\n}"; die $$@ if $$@' < pl-$(datafile)
	@echo

.PHONY: pegex
pegex:
	@echo === Perl 5 Pegex `$(PERL5) -MPegex -e 'print $$Pegex::VERSION'`
	@#export PERL_PEGEX_DEBUG=1
	$(time) $(PERL5) calc-Pegex.pl < $(datafile)
	@echo

.PHONY: prd
prd:
	@echo === Perl 5 Parse::RecDescent `$(PERL5) -MParse::RecDescent -e 'print $$Parse::RecDescent::VERSION'`
	$(time) $(PERL5) calc-PRD.pl < $(datafile)
	@echo

.PHONY: re-gr
re-gr:
	@echo === Perl 5 Regexp::Grammars `$(PERL5) -MRegexp::Grammars -e 'print $$Regexp::Grammars::VERSION'`
	$(time) $(PERL5) calc-RG.pl < $(datafile)
	@echo

.PHONY: perl6
perl6:
	@echo === Perl 6 Rakudo `$(PERL6) --version|sed 's/This is perl6 version //'`
	$(time) $(PERL6) --optimize=3 calc-Rakudo.p6 < $(datafile)
	@echo

.PHONY: fanlang
fanlang:
	@echo === fanlang
	FANLANG_TIMING=0 FANLANG_DEBUG=0 ../fanlang/bin/fanlang calc.fan
	FANLANG_TIMING=0 FANLANG_DEBUG=0 $(time) resty -e 'require "resty.core" require "jit.opt".start("loopunroll=25", "minstitch=5") -- require "jit.v".on("/dev/stderr")' calc.lua < $(datafile)
	@echo

.PHONY: fanlang2
fanlang2:
	@echo === fanlang2
	FANLANG_TIMING=0 FANLANG_DEBUG=0 ../fanlang/bin/fanlang calc.fan
	FANLANG_TIMING=0 FANLANG_DEBUG=0 LD_LIBRARY_PATH=/opt/luajit21/lib $(time) resty --nginx ../lua-nginx-module/work/nginx/sbin/nginx \
				   -I /usr/local/openresty/lualib -e 'require "resty.core" require "jit.opt".start("loopunroll=25", "minstitch=5") -- require "jit.v".on("/dev/stderr")' calc.lua < $(datafile)
	@echo

$(datafile): gen-rand-expr.pl Makefile
	$(PERL5) gen-rand-expr.pl 50000 > $@

