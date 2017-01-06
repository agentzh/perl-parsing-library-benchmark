grammar calc {
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
