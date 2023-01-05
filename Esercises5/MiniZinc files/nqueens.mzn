include "alldifferent.mzn";
include "gecode.mzn";

int: n = 50; %number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

%constraints
constraint alldifferent(q)::domain;
constraint alldifferent([ q[i] + i | i in 1..n])::domain;
constraint alldifferent([ q[i] - i | i in 1..n])::domain;

var int: dist = sum(i in 1..n)(abs(i-q[i]));

%solve minimize dist;
%solve :: int_search(q, dom_w_deg, indomain_random)  minimize dist;

%solve :: int_search(q, dom_w_deg, indomain_random)
%     :: restart_luby(250) minimize dist;
       
solve :: int_search(q, dom_w_deg, indomain_random)
      :: restart_luby(250)
      :: relax_and_reconstruct(q, 85)
      minimize dist;

output [show(dist)];