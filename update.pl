:- module(update,[update/6]).

:- use_module(timeAndStorage).
:- use_module(datastructures).

		
update(assert,Measurement,Keys,Values,_Assert,Result) :-
        measurement(Measurement,Result,update_Assert(Keys,Values)).
        
update(bb,Measurement,Keys,Values,_BB,Result) :-
        measurement(Measurement,Result,update_BB(Keys,Values)).
        
update(avl,Measurement,Keys,Values,Avl,Result) :-
        measurement(Measurement,Result,update_AVL(Keys,Values,Avl,_)).
           
update(mutdict,Measurement,Keys,Values,Mutdict,Result) :-
        measurement(Measurement,Result,update_Mutdict(Keys,Values,Mutdict)).       
               
update(logarr,Measurement,Keys,Values,Array,Result) :-
	measurement(Measurement,Result,update_Logarr(Keys,Values,Array)). 

update(mutarray,Measurement,Keys,Values,Mutarray,Result) :-
	measurement(Measurement,Result,update_Mutarray(Keys,Values,Mutarray)).
	
update(assoc,Measurement,Keys,Values,Assoc,Result) :-
        measurement(Measurement,Result,update_Assoc(Keys,Values,Assoc)).


