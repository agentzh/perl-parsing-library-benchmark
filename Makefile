datafile := expr.txt

# 5k.txt (in seconds):
#   2.462 (PRD) vs 1.662 (RG) (perl 5.16.3)
#   2.457 (PRD) vs 1.739 (RG) (perl 5.18.4)
#   1.436 (PRD) vs 1.556 (RG) (perl 5.20.2)
# 1.755 2.629 2.472

bench: $(datafile)
	-@uname -a
	-@sysctl -n machdep.cpu.brand_string || \
	    grep 'model name' /proc/cpuinfo|head -n1|sed 's/model name\s*: //'
	@echo

	@echo === Perl `perl -e 'print $$^V'` eval
	sed 's/\^/**/g' $(datafile) > pl-$(datafile)
	time perl -e 'my $$a = do { local $$/; <> }; eval "print q{Result: }, $$a, qq{\n}"; die $$@ if $$@' < pl-$(datafile)
	@echo

	@echo === Perl 5 Pegex `perl -MPegex -e 'print $$Pegex::VERSION'`
	@#export PERL_PEGEX_DEBUG=1
	time perl calc-Pegex.pl < $(datafile)
	@echo

	@echo === Perl 5 Parse::RecDescent `perl -MParse::RecDescent -e 'print $$Parse::RecDescent::VERSION'`
	time perl calc-PRD.pl < $(datafile)
	@echo

	@echo === Perl 5 Regexp::Grammars `perl -MRegexp::Grammars -e 'print $$Regexp::Grammars::VERSION'`
	time perl calc-RG.pl < $(datafile)
	@echo

	@echo === Perl 6 Rakudo `perl6 --version|sed 's/This is perl6 version //'`
	time perl6 calc-Rakudo.p6 < $(datafile)
	@echo

$(datafile): gen-rand-expr.pl
	perl gen-rand-expr.pl 10240 > $@

