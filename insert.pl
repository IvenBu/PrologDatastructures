:- module(insert,[insert/5,analyseInsert/5,insertBack/4]).

:- use_module(library(mutarray)).
:- use_module(library(logarr)).
:- use_module(library(mutdict)).
:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(datagenerator).
:- use_module(library(random),[getrand/1,setrand/1]).


insert(assert,Measurement,Keys,Values,Result) :-
        measurement(Measurement,Result,insert_Assert(Keys,Values)).

insert(bb,Measurement,Keys,Values,Result) :-
        measurement(Measurement,Result,insert_BB(Keys,Values)).

insert(avl,Measurement,Keys,Values,Result) :-
        measurement(Measurement,Result,insert_AVL(Keys,Values,empty)).

insert(mutdict,Measurement,Keys,Values,Result) :-
        new_mutdict(Mutdict),
        measurement(Measurement,Result,insert_Mutdict(Keys,Values,Mutdict)).

insert(logarr,Measurement,Keys,Values,Result) :-
	new_array(Array),
	measurement(Measurement,Result,insert_Logarr(Keys,Values, Array)).

insert(mutarray,Measurement,Keys,Values,Result) :-
	length(Keys,X),
	new_mutarray(Mutarray,X),
	measurement(Measurement,Result,insert_Mutarray(Keys,Values,Mutarray)).

insert(assoc,Measurement,Keys,Values,Result) :-
        measurement(Measurement,Result,insert_Assoc(Keys,Values,assoc)).


%Um diesmal die befüllte Datenstruktur zurück zu geben

insertBack(assert,Keys,Values,_Back) :-
        insert_Assert(Keys,Values).

insertBack(bb,Keys,Values,_Back) :-
        insert_BB(Keys,Values).

insertBack(avl,Keys,Values,Back) :-
        insert_AVLBack(Keys,Values,empty,Back).

insertBack(mutdict,Keys,Values,Back) :-
        new_mutdict(Mutdict),
        insert_MutdictBack(Keys,Values,Mutdict,Back).

insertBack(logarr,Keys,Values,Back) :-
	new_array(Array),
	insert_LogarrBack(Keys,Values, Array,Back).

insertBack(mutarray,Keys,Values,Back) :-
	length(Keys,X),
	new_mutarray(Mutarray,X),
	insert_MutarrayBack(Keys,Values,Mutarray,Back).

insertBack(assoc,Keys,Values,Back) :-
        insert_AssocBack(Keys,Values,assoc,Back).


       
