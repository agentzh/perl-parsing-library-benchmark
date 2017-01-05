#!/usr/bin/env perl

use v5.10.1;
use strict;
use warnings;

use Time::HiRes qw( time );
use List::Util ();
use Parse::RecDescent;

my $grammar = <<'_EOC_';
    expr: <leftop: term add_op term>
        {
            my $list = $item[1];
            my $res = shift @$list;
            while (@$list) {
                my $op = shift @$list;
                my $term = shift @$list;
                if ($op eq '+') {
                    $res += $term;
                } else {
                    $res -= $term;
                }
            }
            $return = $res;
        }

    add_op: /[+-]/

    term: <leftop: factor mul_op factor>
        {
            my $list = $item[1];
            my $res = shift @$list;
            while (@$list) {
                my $op = shift @$list;
                my $atom = shift @$list;
                if ($op eq '*') {
                    $res *= $atom;
                } else {
                    $res /= $atom;
                }
            }
            $return = $res;
        }

    mul_op: /[*\/]/

    factor: <rightop: atom '^' atom>
        {
            $return = List::Util::reduce { $b ** $a } reverse @{ $item[1] }
        }

    atom: number
        | '(' <commit> expr ')'  { $return = $item{expr}; }
        | <error?> <reject>

    number: /[-+]?\d+(?:\.\d+)?/
_EOC_

#$::RD_HINT = 1;

my $parser = Parse::RecDescent->new($grammar) or die "failed to instantiate PRD_Calc!\n";

my $input = @ARGV ? shift : do { local $/; <> };

my $begin = time;
my $res = $parser->expr($input);
my $elapsed = time - $begin;

printf "Elapsed: %.03f sec.\n", $elapsed;

if ($res) {
    say "Result: $res";

} else {
    die "Failed to parse text.";
}
