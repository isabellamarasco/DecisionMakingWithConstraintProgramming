%First part exercise 2
%Alfonso Esposito 1057171  
%Isabella Marasco

%Consider n-Queens all different mmodel
%Post the alldifferent constraints either by using global costraints or by decomposing them
%Search for one solution for N = 28, 29 and 30 using the inputer order of the variables and the values with Gecode
%Report the number of the failures and the total time of the two models in a table

% Alldifferent model

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.  

% decomposition of

%constraint alldifferent(q)::domain;
constraint forall(i,j in 1..n where i < j)(q[i] != q[j]);

%constraint alldifferent([ q[i] + i | i in 1..n])::domain;
constraint forall(i,j in 1..n where i < j)(q[i] + i != q[j] + j);

%constraint alldifferent([ q[i] - i | i in 1..n])::domain;
constraint forall(i,j in 1..n where i < j)(q[i] - i != q[j] - j);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve :: int_search(q, input_order, indomain_min) satisfy; 


%%I risultati con la decoposition sono peggiori perchè con i global abbiamo GAC mentre con la decompsoition abbiamo AC(xi!=xj).
%In this case GAC on the original costraint (global) is stonger than AC on the constraints in the decomposition, this why AC has to achieve the max before backtracking and then he must consider more attempt than the GAC, and from that derives more failures and consequently more time.