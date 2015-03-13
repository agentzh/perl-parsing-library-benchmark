#!/usr/bin/env perl

use strict;
use warnings;

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

my $input = (shift || do { local $/; <> });
my $res = $parser->expr($input);
if ($res) {
    print "Result: $res\n";

} else {
    die "Failed to parse text.";
}

