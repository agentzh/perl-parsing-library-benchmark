#!/usr/bin/env perl

use v5.10.1;
use strict;
use warnings;

use Time::HiRes qw( time );
use List::Util qw( reduce );

my $parser = do {
    use Regexp::Grammars;

    qr{
        <nocontext:>
        <expr>

        <rule: expr>
            <[term]>+ % <[add_op]>
            <MATCH= (?{
                my $terms = $MATCH{term};
                my $ops = $MATCH{add_op};
                my $res = shift @$terms;
                while (@$terms) {
                    my $op = shift @$ops;
                    my $term = shift @$terms;
                    if ($op eq '+') {
                        $res += $term;
                    } else {
                        $res -= $term;
                    }
                }
                $res;
            })>

        <token: add_op>
            [-+]

        <rule: term>
            <[factor]>+ % <[mul_op]>
            <MATCH= (?{
                my $factors = $MATCH{factor};
                my $ops = $MATCH{mul_op};
                my $res = shift @$factors;
                while (@$factors) {
                    my $op = shift @$ops;
                    my $factor = shift @$factors;
                    if ($op eq '*') {
                        $res *= $factor;
                    } else {
                        $res /= $factor;
                    }
                }
                $res;
            })>

        <token: mul_op>
            [*/]

        <rule: factor>
            <[atom]>+ % \^
            #<minimize:>
            <MATCH= (?{
                my $list = $MATCH{atom};
                #warn Dumper($list);
                reduce { $b ** $a } reverse @{ $MATCH{atom} }
            })>

        <rule: atom>
              <MATCH=number>
            | \( <MATCH=expr> \)

        <token: number>
            [-+]? \d+ (?:\.\d+)?
    }
};

my $text = (shift // do { local $/; <> });

my $begin = time;
if ($text =~ $parser) {
    my $elapsed = time - $begin;
    printf "Elapsed: %.03f sec.\n", $elapsed;

    say "Result: $/{expr}";

} else {
    say {*STDERR} $_ for @!;
}
