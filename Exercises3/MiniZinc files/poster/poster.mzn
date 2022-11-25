include "globals.mzn";

%variables and domain
int: n; 
int: h;
int: w;

array[1..n] of int: hs;
array[1..n] of int: ws;

%array[1..n] of var 0..w-1: W;
%array[1..n] of var 0..h-1: H;
array[1..n, 0..1] of var 0..w-1: m;


%constraint forall(i in 1..n)( W[i] + ws[i] <= w /\ H[i] + hs[i] <= h);
%constraint diffn(W,H, ws, hs);
constraint forall(i in 1..n)( m[i,0] + ws[i] <= w /\ m[i,1] + hs[i] <= h);
constraint diffn(m[..,0],m[..,1], ws, hs);

%solve satisfy;
solve::int_search(m, input_order, indomain_min) satisfy;






