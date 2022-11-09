% variables and domains
int: n;
array [0..n-1] of var 0..n-1: X;

%constraint
%for all i, 𝑋i = ∑j∈[1..n](Xj= 𝑖)
constraint forall(i in 0..n-1)(X[i] = sum(j in 0..n-1)(X[j]=i));

%implied constraints
%∑i∈[0..n-1] 𝑋i = 𝑛 and %  ∑i∈[0..n-1] 𝑋i ∗ 𝑖 = 𝑛
constraint sum(i in 0..n-1) ( X[i] ) = n ;
constraint sum(i in 0..n-1) ( X[i]*i ) = n;

solve satisfy;








