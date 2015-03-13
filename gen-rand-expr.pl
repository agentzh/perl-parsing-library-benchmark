#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

my $count = shift // 1024 * 10;
my $maxnum = 10000;
my @operators = qw( + - * / );
my @spaces = (' ', "\t", "\n");

sub gen_num () {
    my $n = rand($maxnum * 2) - $maxnum;
    my $res = rand 2 > 0 ? $n : int $n;
    if ($res < 0) {
        print "($res)";
    } else {
        print $res;
    }
}

sub gen_space () {
    my $n = int rand 4;
    for (my $i = 0; $i < $n; $i++) {
        print $spaces[int rand scalar @spaces];
    }
}

sub gen_op () {
    print $operators[int rand scalar @operators];
}

gen_space();
gen_num();
gen_space();

for (my $i = 0; $i < $count; $i++) {
    gen_space();
    gen_op();
    gen_space();
    gen_num();
}

print "*(5-(3-1)*2^3^4+10)";

gen_space();
