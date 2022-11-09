include "alldifferent.mzn";
include "lex_lesseq.mzn";
% Combined alldifferent & symmetry breaking model
int: n;
array [1..n] of var 1..n: X;
array [1..n,1..n] of var bool: B;

% alldiff model
constraint alldifferent(X)::domain;
constraint alldifferent([ X[i] + i | i in 1..n])::domain;
constraint alldifferent([ X[i] - i | i in 1..n])::domain;

% Integration of the Boolean model 
constraint symmetry_breaking_constraint(
    % Lexicographic symmetry breaking constraints
    % lex≤([1, 2, 4],[1, 3, 3]) -> true
    % lex≤(B , π(B)) for all π
    lex_lesseq(array1d(B), [ B[j,i] | i,j in 1..n ]) %->j,i
/\  lex_lesseq(array1d(B), [ B[i,j] | i in reverse(1..n), j in 1..n ]) %->reverse i,j
/\  lex_lesseq(array1d(B), [ B[j,i] | i in 1..n, j in reverse(1..n) ]) %->reverse j,i
/\  lex_lesseq(array1d(B), [ B[i,j] | i in 1..n, j in reverse(1..n) ]) %->i,reverse j
/\  lex_lesseq(array1d(B), [ B[j,i] | i in reverse(1..n), j in 1..n ]) %->j,reverse i
/\  lex_lesseq(array1d(B), [ B[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i,j in reverse(1..n) ])
);
 
% Channeling constraint
% forall i,j Xi=j ↔ Bij=1
constraint forall (i,j in 1..n) ( B[i,j] <-> (X[i]=j));

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;






