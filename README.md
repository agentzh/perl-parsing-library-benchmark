Name
====

perl-parsing-library-benchmark - Benchmark programs for Perl's parsing libraries

Table of Contents
=================

* [Name](#name)
* [Description](#description)
* [Typical benchmark results](#typical-benchmark-results)
    * [iMac (late-2014)](#imac-late-2014)
    * [ThinkPad W530](#thinkpad-w530)
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

iMac (late 2014)
----------------

```
perl gen-rand-expr.pl 10240 > expr.txt
Darwin imac.local 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:47 PST 2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64
Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

=== Perl v5.20.2 eval
sed 's/\^/**/g' expr.txt > pl-expr.txt
time perl -e 'my $a = <>; eval "print q{Result: }, $a, qq{\n}"; die $@ if $@' < pl-expr.txt
Result: -3.2286703480205e+26

real    0m0.009s
user    0m0.007s
sys 0m0.001s

=== Perl 5 Pegex 0.60
time perl calc-Pegex.pl < expr.txt
Result: -3.2286703480205e+26

real    0m1.037s
user    0m1.024s
sys 0m0.008s

=== Perl 5 Parse::RecDescent 1.967009
time perl calc-PRD.pl < expr.txt
Result: -3.2286703480205e+26

real    0m3.873s
user    0m3.807s
sys 0m0.057s

=== Perl 5 Regexp::Grammars 1.039
time perl calc-RG.pl < expr.txt
Result: -3.2286703480205e+26

real    0m4.582s
user    0m3.777s
sys 0m0.796s

=== Perl 6 Rakudo 2015.02-291-g076da82 built on MoarVM version 2015.02-57-gc6e8df8
time perl6 calc-Rakudo.p6 < expr.txt
Result: -3.2286703480205e+26

real    0m13.065s
user    0m12.698s
sys 0m0.322s
```

[Back to TOC](#table-of-contents)

ThinkPad W530
-------------

```
perl gen-rand-expr.pl 10240 > expr.txt
Linux w530 3.18.7-100.fc20.x86_64 #1 SMP Wed Feb 11 19:01:50 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
Intel(R) Core(TM) i7-3920XM CPU @ 2.90GHz

=== Perl v5.20.2 eval
sed 's/\^/**/g' expr.txt > pl-expr.txt
time perl -e 'my $a = <>; eval "print q{Result: }, $a, qq{\n}"; die $@ if $@' < pl-expr.txt
Result: -3.80290747375141e+23

real    0m0.012s
user    0m0.010s
sys 0m0.001s

=== Perl 5 Pegex 0.60
time perl calc-Pegex.pl < expr.txt
Result: -3.80290747375141e+23

real    0m2.491s
user    0m2.483s
sys 0m0.007s

=== Perl 5 Parse::RecDescent 1.967009
time perl calc-PRD.pl < expr.txt
Result: -3.80290747375141e+23

real    0m6.628s
user    0m6.603s
sys 0m0.023s

=== Perl 5 Regexp::Grammars 1.039
time perl calc-RG.pl < expr.txt
Result: -3.80290747375141e+23

real    0m5.270s
user    0m4.361s
sys 0m0.908s

=== Perl 6 Rakudo 2015.02-291-g076da82 built on MoarVM version 2015.02-57-gc6e8df8
time perl6 calc-Rakudo.p6 < expr.txt
Result: -3.80290747375141e+23

real    0m20.150s
user    0m20.073s
sys 0m0.072s
```

[Back to TOC](#table-of-contents)

Author
======

Yichun Zhang (agentzh) <agentzh@gmail.com>

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2015, by Yichun "agentzh" Zhang (章亦春) <agentzh@gmail.com>, CloudFlare Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

