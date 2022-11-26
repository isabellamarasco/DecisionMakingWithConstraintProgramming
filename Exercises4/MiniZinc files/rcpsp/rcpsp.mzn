include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations


% this is the maximum starting time that can have a task
int: maxStartTime = sum(i in TASKS)(duration[i])- min(duration); 
array[1..n_tasks] of var 0..maxStartTime: S;

% precedence constraint
constraint forall(i in PREC)( (S[pre[i,1]] + duration[pre[i,1]]) <= S[pre[i,2]] );

constraint forall(i in RESOURCES)(
  cumulative(S, duration, row(req,i), L[i])
);

var 0..maxStartTime+min(duration) : makespan = max([S[i]+duration[i]|i in TASKS]);

solve minimize makespan;
%solve :: int_search(S, smallest, indomain_min)  minimize makespan;


output [show(S) ++ show(makespan)];