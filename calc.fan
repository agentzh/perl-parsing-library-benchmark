grammar Arith {
    expr:
      - term(s add-op) -

    add-op:
      / \s* ( [+-] ) \s* /

    term: factor(s mul-op)

    mul-op:
      / \s* ( [*\/] ) \s* /

    factor: atom(s '^')

    atom:
      | number
      | '(' expr ')'

    number:
      / ( -? \d+ (?: \. \d+ )? ) /
}

class Calc {
    method expr (@terms, @ops) {
        #say "terms: ", @terms;
        #say "ops: ", @ops;

        my $res = shift @terms;
        while @terms {
            my $op = shift @ops;
            my $other = shift @terms;

            if $op eq '+' {
                $res += $other;
            } else {
                $res -= $other;
            }
        }
        return $res;
    }

    method term (@factors, @ops) {
        #say "factors: ", @factors;

        my $res = shift @factors;
        while @factors {
            my $op = shift @ops;
            my $other = shift @factors;

            if $op eq '*' {
                $res *= $other;
            } else {
                $res /= $other;
            }
        }
        return $res;
    }

    method factor (@atoms) {
        my $res = pop @atoms;
        while @atoms {
            $res = pow pop(@atoms), $res;
        }
        $res;
    }
}

my $input = slurp "expr.txt";

my $begin = now;
my ($res, $err) = Arith.parse: $input, Calc.new;
printf "Elapsed: %.03f sec\n", now - $begin;

if !defined $res {
    die "Failed to parse: ", $err;
}

say "Result: $res";
