include "globals.mzn";

%VARIABLES

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines
int: maxStartTime = sum(j in JOB, i in MACH)(duration[j,i]); % this is the maximum starting time that can have a task
array[JOB,TASK] of var 0..maxStartTime: S; %start time S for each JOB and its TASK

var int: dummyTask;

%CONSTRAINTS

constraint forall(j in JOB, i in TASK)(S[j,i] >= 0); %No task can start with negative time

% precedence constraint
constraint forall(j in JOB, i in 1..length(TASK)-1)( (S[j,i] + duration[j,machine[j,i]]) <= S[j, i+1] );
constraint forall(j in JOB, i in 1..length(TASK))(S[j,i] + duration[j,machine[j,i]] < dummyTask); %all tasks must be in precedence before than dummy task.
                                                                                                         
% disjunctive constraint
constraint forall(m in MACH)(
    disjunctive([S[j,i] | j in JOB, i in TASK where machine[j,i]==m ], [ duration[j,m] | j in JOB ] )
);

% OBJECTIVE FUNCTION
%var 0..maxStartTime: makespan = max(j in JOB)(S[j,length(TASK)]+duration[j,machine[j,length(TASK)]]);
var 0..maxStartTime: makespan = dummyTask;

%solve minimize makespan;
solve :: int_search(S, smallest, indomain_min)  minimize makespan;