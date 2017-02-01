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
Linux fedora64 4.8.13-100.fc23.x86_64 #1 SMP Fri Dec 9 14:51:40 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
Intel(R) Core(TM) i7-4980HQ CPU @ 2.80GHz

ls -lh expr.txt
-rw-r--r--. 1 agentzh agentzh 536K Feb  1 13:56 expr.txt

=== Perl v5.24.0 eval
sed 's/\^/**/g' expr.txt > pl-expr.txt
/bin/time /opt/perl524/bin/perl -e 'my $a = do { local $/; <> }; eval "print q{Result: }, $a, qq{\n}"; die $@ if $@' < pl-expr.txt
Result: 3.43244724942325e+33
0.02user 0.00system 0:00.02elapsed 100%CPU (0avgtext+0avgdata 6388maxresident)k
0inputs+0outputs (0major+784minor)pagefaults 0swaps

=== Perl 5 Pegex 0.63
/bin/time /opt/perl524/bin/perl calc-Pegex.pl < expr.txt
Elapsed: 2.110 sec.
Result: 3.43244724942325e+33
2.11user 0.00system 0:02.12elapsed 99%CPU (0avgtext+0avgdata 22800maxresident)k
0inputs+0outputs (0major+4866minor)pagefaults 0swaps

=== Perl 5 Parse::RecDescent 1.967013
/bin/time /opt/perl524/bin/perl calc-PRD.pl < expr.txt
Elapsed: 35.073 sec.
Result: 3.43244724942325e+33
32.64user 2.26system 0:35.11elapsed 99%CPU (0avgtext+0avgdata 24596maxresident)k
0inputs+0outputs (0major+1949141minor)pagefaults 0swaps

=== Perl 6 Rakudo This is Rakudo version 2017.01-94-g4e7ab2047 built on MoarVM version 2017.01 implementing Perl 6.c.
/bin/time /home/agentzh/git/rakudo/install/bin/perl6 --optimize=3 calc-Rakudo.p6 < expr.txt
Elapsed: 17.217 sec.
Result: 3.43244724942324e+33
17.26user 0.17system 0:17.53elapsed 99%CPU (0avgtext+0avgdata 333784maxresident)k
0inputs+0outputs (0major+79227minor)pagefaults 0swaps

=== fanlang
FANLANG_TIMING=0 FANLANG_DEBUG=0 ../fanlang/bin/fanlang calc.fan
FANLANG_TIMING=0 FANLANG_DEBUG=0 /bin/time resty -e 'require "resty.core" require "jit.opt".start("loopunroll=25", "minstitch=5") -- require "jit.v".on("/dev/stderr")' calc.lua < expr.txt
Elapsed: 0.114 sec
Result: 3.4324472494232e+33
0.14user 0.01system 0:00.16elapsed 93%CPU (0avgtext+0avgdata 11652maxresident)k
0inputs+0outputs (0major+3689minor)pagefaults 0swaps
```

It is worth noting that the `Regexp::Grammar` version is just too slow and uses
too much memory to be included in the default benchmark Makefile target.
You can manually run its test like below:

```bash
make re-gr
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

