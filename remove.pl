:- module(remove,[remove/5]).

:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(library(sets),[subtract/3]).
:- use_module(datagenerator).
:- use_module(insert).
:- use_module(library(random),[getrand/1,setrand/1]).
:- use_module(library(lists)).


remove(assert,Measurement,Keys,_Assert,Result) :-			
        measurement(Measurement,Result,remove_Assert(Keys)).
        
remove(bb,Measurement,Keys,_BB,Result) :-
	remove_dups(Keys,Pruned),
        measurement(Measurement,Result,remove_BB(Pruned)).
        
remove(avl,Measurement,Keys,Avl,Result) :-
        measurement(Measurement,Result,remove_AVL(Keys,Avl)).

remove(mutdict,Measurement,Keys,Mutdict,Result) :-
        measurement(Measurement,Result,remove_Mutdict(Keys,Mutdict)).

remove(logarr,_,_,_,na).
remove(mutarray,_,_,_,na).
remove(assoc,_,_,_,na).
