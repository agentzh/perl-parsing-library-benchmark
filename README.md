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
Darwin mbp15.local 15.6.0 Darwin Kernel Version 15.6.0: Mon Jan  9 23:07:29 PST 2017; root:xnu-3248.60.11.2.1~1/RELEASE_X86_64 x86_64
Intel(R) Core(TM) i7-4980HQ CPU @ 2.80GHz

=== Perl v5.24.0 eval
sed 's/\^/**/g' expr.txt > pl-expr.txt
time /usr/local/Cellar/perl/5.24.0_1/bin/perl -e 'my $a = do { local $/; <> }; eval "print q{Result: }, $a, qq{\n}"; die $@ if $@' < pl-expr.txt
Result: -1.25620511453418e+31

real    0m0.019s
user    0m0.016s
sys    0m0.002s

=== Perl 5 Pegex 0.63
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-Pegex.pl < expr.txt
Elapsed: 1.282 sec.
Result: -1.25620511453418e+31

real    0m1.299s
user    0m1.291s
sys    0m0.006s

=== Perl 5 Parse::RecDescent 1.967013
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-PRD.pl < expr.txt
Elapsed: 13.444 sec.
Result: -1.25620511453418e+31

real    0m13.490s
user    0m13.354s
sys    0m0.133s

=== Perl 5 Regexp::Grammars 1.045
time /usr/local/Cellar/perl/5.24.0_1/bin/perl calc-RG.pl < expr.txt
Elapsed: 30.194 sec.
Result: -1.25620511453418e+31

real    0m35.146s
user    0m17.794s
sys    0m15.159s

=== Perl 6 Rakudo This is Rakudo version 2017.01 built on MoarVM version 2017.01 implementing Perl 6.c.
time /Users/agentzh/git/rakudo/install/bin/perl6 --optimize=3 calc-Rakudo.p6 < expr.txt
Elapsed: 8.387 sec.
Result: -1.25620511453418e+31

real    0m8.798s
user    0m8.617s
sys    0m0.101s

=== fanlang
FANLANG_TIMING=0 FANLANG_DEBUG=0 ../fanlang/bin/fanlang calc.fan
FANLANG_TIMING=0 FANLANG_DEBUG=0 time resty -e 'require "resty.core" require "jit.opt".start("loopunroll=25", "minstitch=5") -- require "jit.v".on("/dev/stderr")' calc.lua < expr.txt
Elapsed: 0.076 sec
Result: -1.2562051145342e+31
        0.15 real         0.11 user         0.01 sys
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

