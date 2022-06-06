:- module(datagenerator,[data/3,datagenerator/4,datagenerator/5,datagenerator/4]).

:- use_module(library(sets),[del_element/3]).
:- use_module(library(between)).
:- use_module(library(lists)).
:- use_module(library(file_systems),[file_members_of_directory/3]).
:- use_module(library(random),[random_member/2]).
:- use_module(library(random)).

include_type_definition(_-FullPath) :- consult(FullPath).

:- file_members_of_directory('./SICStusPrologFuzzer/','*.pl',FileList),
   maplist(include_type_definition,FileList). 

/* Erzeugung der Daten unter der Verwendung der generate/2 Funktion aus dem Fuzzer */

datagenerator(KeyType,ValueType,Size,Keys,Values):-
	data(KeyType,Size,Keys),
	data(ValueType,Size,Values),!.
        	
datagenerator(random,Keys,Size,Data):-
	shuffle(Size,Keys,[],Data),!.

datagenerator(last,Keys,Size,Data):-
	length(Keys,X),
	Helper is X-Size,
	sublist(Keys,List,Helper,Size,0),
	reverse(List, Data),!.

datagenerator(first,Keys,Size,Data):-
	length(Keys,X),
	Helper is X-Size,
	sublist(Keys,Data,0,Size,Helper),!.
             
data(string,X, Data) :-
        generate(list(list(integer([between(33,126)])),[size:X]),Data),!.

data(atom,X, Data) :-
        generate(list(atom([alph]),[size:X]),Data),!.

data(ordIdx,X,Data) :-
        numlist(1,X, Data),!.
        
data(revIdx,X,Data) :-
        numlist(1,X,H),
	reverse(H,Data),!.

data(unordIdx,X,Data) :-
        numlist(1,X,H),
	shuffle(X,H,[],Data),!.
        
data(integer,X,Data) :-
        generate(list(integer([]),[size:X]),Data),!.
        

/* Für die random Auswahl von X Werten aus einer Liste*/

shuffle(0,_,Values,Values).

shuffle(X,H,Acc,Data) :-
	random_select(Value, H, Rest),
	SizeNew is X - 1,
	shuffle(SizeNew,Rest,[Value|Acc],Data).
        


	
