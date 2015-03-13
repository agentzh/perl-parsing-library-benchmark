#!/usr/bin/env perl6

use v6;

# time: 12.1s ~ 12.5s
# mem: 180MB

my grammar Arith {
    rule TOP {
        | <.ws> <expr> { make $<expr>.made }
        | { self.panic("Bad expression") }
    }

    rule expr {
        | <term> + % <add-op>   { self.do_calc($/, $<term>, $<add-op>) }
        | { self.panic("Bad expression") }
    }

    token add-op {
        | < + - >
        #| { self.panic($/, "Bad addition/substraction operator") }
    }

    rule term {
        | <factor> + % <mul-op>  { make self.do_calc($/, $<factor>, $<mul-op>) }
        | { self.panic($/, "Bad term") }
    }

    token mul-op {
        | < * / >
        #| { self.panic($/, "Bad multiplication/division operator") }
    }

    rule factor {
        | <atom> + % '^'
            {
                make [**] map { $_.made }, @<atom>;
            }
        | { self.panic($/, "Bad factor") }
    }

    rule atom {
        | <number> { make +$<number> }
        | '(' ~ ')' <expr> { make $<expr>.made }
        | { self.panic($/, "Bad atom") }
    }

    rule number {
        <.sign> ? <.pos-num>
        | { self.panic($/, "Bad number") }
    }

    token sign { < + - > }
    token pos-num {
        | <.digit>+ [ \. <digit>+ ]?
        | \. <.digit>+
        | { self.panic($/, "Bad number") }
    }

    method do_calc($/, $operands, $operators) {
        my $res = $operands[0].made;
        my $n = $operands.elems;
        loop (my $i = 1; $i < $n; $i++) {
            my $op = $operators[$i - 1];
            my $num = $operands[$i].made;

            given $op {
                when '+' { $res += $num; }
                when '-' { $res -= $num; }
                when '*' { $res *= $num; }
                default {  # when '/'
                    $res /= $num;
                }
            }
        }
        make $res;
    }

    method panic($/, $msg) {
        my $c = $/.CURSOR;
        my $pos := $c.pos;
        die "$msg found at pos $pos";
    }
}

my $input = (@*ARGS[0] // slurp);

try Arith.parse($input);
if $! {
    say "Parse failed: ", $!.message;

} elsif $/ {
    say "Result: ", $();

} else {
    say "Parse failed.";
}

