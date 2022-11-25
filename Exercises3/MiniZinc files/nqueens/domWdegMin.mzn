% Alldifferent model
include "alldifferent.mzn";

int: n;
array [1..n] of var 1..n: q;

constraint alldifferent(q)::domain;
constraint alldifferent([ q[i] + i | i in 1..n])::domain;
constraint alldifferent([ q[i] - i | i in 1..n])::domain;

% Search for all solutions, using N = 30, 35, 45, and 50.
solve :: int_search(q, dom_w_deg, indomain_min)  satisfy;

% dom_w_deg: choose the variable with the smallest value of domain size divided by weighted degree, which is the number of times it has been in a constraint that caused failure earlier in the search
% indomain_min: assign the variable its smallest domain value