% Alldifferent model
include "alldifferent.mzn";

int: n;
array [1..n] of var 1..n: q;

constraint alldifferent(q)::domain;
constraint alldifferent([ q[i] + i | i in 1..n])::domain;
constraint alldifferent([ q[i] - i | i in 1..n])::domain;

% Search for all solutions, using N = 30, 35, 45, and 50.
solve :: int_search(q, first_fail, indomain_min)  satisfy;

% smallest: choose the variable with the smallest value in its domain.
% indomain_min: assign the variable its smallest domain value