#!/usr/bin/env perl

use v5.10.1;
use strict;
use warnings;

use Time::HiRes qw( time );
use Pegex qw( pegex );

my $grammar = <<_EOC_;
expr: term+ % add-op

add-op: / ( [+-] ) /
term: factor+ % mul-op

mul-op: / ( ['*/'] ) /
factor: atom+ % '^'

atom: number
    | /- '(' / expr / ')' -/

number: /- ( '-'? DIGIT+ (: '.' DIGIT+ )? ) -/
_EOC_

# use XXX; XXX pegex($grammar)->grammar->tree;

{
    package Calc;

    use base 'Pegex::Tree';
    use List::Util qw( reduce );
    use vars qw( $a $b );  # just to suppress a warning in older perls

    sub got_expr {
        my ($self, $list) = @_;
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
        return $res;
    }

    sub got_term {
        my ($self, $list) = @_;
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
        return $res;
    }

    sub got_factor {
        my ($self, $list) = @_;
        reduce { $b ** $a } reverse @$list;
    }

    sub got_atom {
        my ($self, $list) = @_;
        ref $list ? $list->[0] : $list;
    }
}

my $input = @ARGV ? shift : do { local $/; <> };

my $begin = time;
my $res = pegex($grammar, 'Calc')->parse($input);
my $elapsed = time - $begin;

printf "Elapsed: %.03f sec.\n", $elapsed;
say "Result: $res",
