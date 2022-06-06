:- module(timeAndStorage,[measurement/3]).

:- use_module(datastructures).

/* Time */
measurement(time,Time,Prozedur):-
        clean,
        statistics(walltime,[Start,_]),
        Prozedur,
        !,
        statistics(walltime,[Stop,_]),
        Time is Stop - Start,!.

/* Storage*/
measurement(heap,Bytes,Procedure) :-
        clean,
        statistics(heap,[Start,_]),
        Procedure,
        !,
        statistics(heap,[Stop,_]),
        clean,
        Bytes is Stop-Start,!.

measurement(garbage,[NumberGC,Bytes,Time],Procedure) :-
        clean,
        statistics(garbage_collection,[Start1,Start2,Start3]),
        Procedure,
        !,
        statistics(garbage_collection,[Stop1,Stop2,Stop3]),
        clean,
        NumberGC is Stop1 - Start1,
        Bytes is Stop2 - Start2,
        Time is Stop3 - Start3,
        !.

/* Storage:global_stack_used, local_stack_used, trail_used, choice_used*/
measurement(Storage,Bytes,Procedure) :-
        clean,
        statistics(Storage,Start),
        Procedure,
        !,
        statistics(Storage,Stop),
        clean,
        Bytes is Stop-Start,!.



