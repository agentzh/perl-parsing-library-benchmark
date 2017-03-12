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

# TODO: we could use orelse to connect to the following
# 2 lines once we have it in fanlang.
my $infile = shift @*ARGS;
die "No input file specified.\n" unless defined $infile;

# TODO: we could use orelse to connect to the following
# 2 lines once we have it in fanlang.
my $input = slurp $infile;
die "failed to read file $infile: $!" unless defined $input;

my $begin = now;
my $res = Arith.parse: $input, Calc.new;
my $err = $!;

printf "Elapsed: %.03f sec\n", now - $begin;

if !defined $res {
    die "Failed to parse: $infile", $err // "unknown", "\n";
}

say "Result: $res";
