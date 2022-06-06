:- module(get,[get/6]).

:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(insert).
:- use_module(datagenerator).
:- use_module(library(random),[getrand/1,setrand/1]).


get(assert,Measurement,Keys,_Assert,Result,_Back) :-
        measurement(Measurement,Result,get_Assert(Keys)).
        
get(bb,Measurement,Keys,_BB,Result,_Back) :-
        measurement(Measurement,Result,get_BB(Keys)).

get(avl,Measurement,Keys,Avl,Result,_Back) :-
        measurement(Measurement,Result,get_AVL(Keys,Avl)).

get(mutdict,Measurement,Keys,Mutdict,Result,_Back) :-
        measurement(Measurement,Result,get_Mutdict(Keys,Mutdict)).

get(logarr,Measurement,Keys,Array,Result,_Back) :-
	measurement(Measurement,Result,get_Logarr(Keys,Array)).

get(mutarray,Measurement,Keys,Mutarray,Result,_Back) :-
	measurement(Measurement,Result,get_Mutarray(Keys,Mutarray)).
	
get(assoc,Measurement,Keys,Assoc,Result,_Back) :-
        measurement(Measurement,Result,get_Assoc(Keys,Assoc)).

