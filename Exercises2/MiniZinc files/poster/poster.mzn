include "globals.mzn";

%variables and domain
int: n; 
int: h;
int: w;

array[1..n] of int: hs;
array[1..n] of int: ws;

array[1..n] of var 0..w-1: W;
array[1..n] of var 0..h-1: H;


constraint forall(i in 1..n)( W[i] + ws[i] <= w /\ H[i] + hs[i] <= h);

%naive 
%constraint forall(i, j in 1..n where i<j)
%                (W[i]+ ws[i] <= W[j] \/
%                  W[j]+ ws[j] <= W[i] \/
%                 H[i]+ hs[i] <= H[j] \/ 
%                  H[j]+ hs[j] <= H[i]);

%global constraint
constraint diffn(W, H, ws, hs);


solve satisfy;







