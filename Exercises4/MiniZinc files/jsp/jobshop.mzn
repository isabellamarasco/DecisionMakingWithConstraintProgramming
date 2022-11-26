include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines


int: maxStartTime = sum(j in JOB, i in MACH)(duration[j,i]); % this is the maximum starting time that can have a task
array[JOB,TASK] of var 0..maxStartTime: S;

% precedence constraint
constraint forall(j in JOB, i in 1..length(TASK)-1)( (S[j,i] + duration[j,machine[j,i]]) <= S[j, i+1] );

% disjunctive constraint
constraint forall(m in MACH)(
    disjunctive([S[j,t] | j in JOB, t in TASK where machine[j,t]==m ], [ duration[j,m] | j in JOB ] )
);

% makespan
var 0..maxStartTime: makespan = max(j in JOB)(S[j,length(TASK)]+duration[j,machine[j,length(TASK)]]);

%solve minimize makespan;
solve :: int_search(S, smallest, indomain_min)  minimize makespan;

output [show(S) ++ show(makespan)];