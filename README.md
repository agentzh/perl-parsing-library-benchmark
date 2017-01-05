Name
====

perl-parsing-library-benchmark - Benchmark programs for Perl's parsing libraries

Table of Contents
=================

* [Name](#name)
* [Description](#description)
* [Typical benchmark results](#typical-benchmark-results)
    * [15-inch Retina Macbook Pro (mid-2015)](#15-inch-retina-macbook-pro-mid-2015)
* [Author](#author)
* [Copyright and License](#copyright-and-license)

Description
===========

This repos holds a bunch of simple infix arithmetic expression calculators implemented with various different Perl 5 and
Perl 6 parsing libraris and/or builtins:

* Perl 5 [Pegex](https://metacpan.org/release/Pegex)
* Perl 5 [Regexp::Grammars](https://metacpan.org/release/Parse-RecDescent)
* Perl 5 [Parse::RecDescent](https://metacpan.org/release/Regexp-Grammars)
* Perl 6 [Rakudo](http://rakudo.org/)

Right now only top-down parsers are considered.

To run the benchmark on your box, just type the `make` command.

If you want to use a particular perl or perl6 executable, then just make it visible in your `PATH` environment.

Typical benchmark results
=========================

15-inch Retina Macbook Pro (mid-2015)
-------------------------------------

```console
$ make
Darwin mbp15.local 15.6.0 Darwin Kernel Version 15.6.0: Thu Sep  1 15:01:16 PDT 2016; root:xnu-3248.60.11~2/RELEASE_X86_64 x86_64
Intel(R) Core(TM) i7-4980HQ CPU @ 2.80GHz

=== Perl v5.24.0 eval
sed 's/\^/**/g' expr.txt > pl-expr.txt
time /usr/local/Cellar/perl/5.24.0_1/bin/perl -e 'my $a = do { local $/; <> }; eval "print q{Result: }, $a, qq{\n}"; die $@ if $@' < pl-expr.txt
Result: -1.25620511453418e+31

real    0m0.020s
user    0m0.016s
sys    0m0.003s

=== Perl 5 Pegex 0.61
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-Pegex.pl < expr.txt
Elapsed: 1.327 sec.
Result: -1.25620511453418e+31

real    0m1.349s
user    0m1.338s
sys    0m0.008s

=== Perl 5 Parse::RecDescent 1.967013
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-PRD.pl < expr.txt
Elapsed: 13.787 sec.
Result: -1.25620511453418e+31

real    0m13.839s
user    0m13.695s
sys    0m0.139s

=== Perl 5 Regexp::Grammars 1.045
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-RG.pl < expr.txt
Elapsed: 32.473 sec.
Result: -1.25620511453418e+31

real    0m41.326s
user    0m19.237s
sys    0m19.235s

=== Perl 6 Rakudo This is Rakudo version 2016.12-223-g6d28c1d built on MoarVM version 2016.12-60-g36f3385 implementing Perl 6.c.
time /Users/agentzh/git/rakudo/install/bin/perl6 calc-Rakudo.p6 < expr.txt
Elapsed: 9.382 sec.
Result: -1.25620511453418e+31

real    0m9.810s
user    0m9.610s
sys    0m0.117s
```

[Back to TOC](#table-of-contents)

Author
======

Yichun Zhang (agentzh) <agentzh@gmail.com>

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2015-2016, by Yichun "agentzh" Zhang (章亦春) <agentzh@gmail.com>, OpenResty Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

