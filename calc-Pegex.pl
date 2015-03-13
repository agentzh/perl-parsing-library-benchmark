#!/usr/bin/env perl

use strict;
use warnings;

use Pegex qw( pegex );

my $grammar = <<_EOC_;
expr: term+ % add-op

add-op: /- ( [ '+-' ] ) -/
term: factor+ % mul-op

mul-op: /- ( [ '*/' ] ) -/
factor: atom+ % /- '^' -/

atom: number
    | /- '(' / expr / ')' -/

number: /- ( '-'? DIGIT+ (: '.' DIGIT+ )? ) -/
_EOC_

{
    package Calc;
    use base 'Pegex::Tree';
    use List::Util qw( reduce );

    sub got_expr {
        my ($self, $list) = @_;
        return $list unless ref $list;

        my $res = shift @$list;
        while (@$list) {
            my $op = shift @$list;
            my $other = shift @$list;
            if ($op eq '+') {
                $res += $other;
            } else {  # $op eq '-'
                $res -= $other;
            }
        }
        #warn "expr value: $res";
        return $res;
    }

    sub got_term {
        my ($self, $list) = @_;
        return $list unless ref $list;

        my $res = shift @$list;
        while (@$list) {
            my $op = shift @$list;
            my $other = shift @$list;
            if ($op eq '*') {
                $res *= $other;
            } else {  # $op eq '/'
                $res /= $other;
            }
        }
        #warn "term value: $res";
        return $res;
    }

    sub got_factor {
        my ($self, $list) = @_;
        return $list unless ref $list;

        my $res = reduce { $b ** $a } reverse @$list;
        #warn "factor value: $res";
        $res;
    }

    sub got_atom {
        my ($self, $list) = @_;
        return $list unless ref $list;
        $list->[0];
    }
}

my $input = (shift || do { local $/; <> });
print "Result: ", pegex($grammar, 'Calc')->parse($input), "\n";

