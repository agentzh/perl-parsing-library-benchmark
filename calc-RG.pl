#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

use List::Util ();
#use Data::Dumper;

my $parser = do {
    use Regexp::Grammars;

    qr{
        <nocontext:>
        <expr>

        <rule: expr>
            <[term]>+ % <[add_op]>
            #<minimize:>
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
            #<minimize:>
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
                List::Util::reduce { $b ** $a } reverse @{ $MATCH{atom} }
            })>

        <rule: atom>
              <MATCH=number>
            | \( <MATCH=expr> \)

        <token: number>
            [-+]? \d+ (?:\.\d+)?
    }
};

my $text = shift // <>;

if ($text =~ $parser) {
    say "Result: $/{expr}";

} else {
    say {*STDERR} $_ for @!;
}
