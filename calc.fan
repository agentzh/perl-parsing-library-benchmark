
grammar Arith {
    expr:
      - term(s add-op) -

    add-op:
      /\s* ( [+-] ) \s*/

    term: factor(s mul-op)

    mul-op:
      /\s* ( [*\/] ) \s*/

    factor: atom(s '^')

    atom:
      | number
      | '(' expr ')'

    number:
      /( -? \d+ (?: \. \d+ )? )/
}

class Calc is Actions {
    method expr (@terms, @ops) {
        my $res = shift @terms;
        #my $n = self.get-line;
        while @terms {
            my $op = shift @ops;
            my $other = shift @terms;

            if $op eq '+' {
                $res += $other;
            } else {
                $res -= $other;
            }
        }
        $res;
    }

    method term (@factors, @ops) {
        my $res = shift @factors;
        #my $n = self.get-line;
        while @factors {
            my $op = shift @ops;
            my $other = shift @factors;

            if $op eq '*' {
                $res *= $other;
            } else {
                $res /= $other;
            }
        }
        $res;
    }

    method factor (@atoms) {
        my $res = pop @atoms;
        #my $n = self.get-line;
        while @atoms {
            $res = @atoms.pop ** $res;
        }
        $res;
    }
}

my $input = slurp shift @*ARGS;

my $begin = now;
my ($res, $err) = Arith.parse: $input, Calc.new;
printf "Elapsed: %.03f sec\n", now - $begin;

if !defined $res {
    die "Failed to parse: ", $err;
}

say "Result: $res";
