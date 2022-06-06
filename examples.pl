:- use_module(insert).
:- use_module(remove).
:- use_module(get).
:- use_module(update).
:- use_module(statistics).
:- use_module(datagenerator).
:- use_module(datastructures).
:- use_module(library(sets),[subtract/3]).

:- use_module(library(random),[getrand/1,setrand/1]).

  % Datastructures: assert,bb,assoc,avl,mutdict,logarr und  mutarray
  % KeyTypes: ordIdx,unordIdx, revIdx,integer, atom, string.
  % ValueTypes: integer, atom, string
  % StorageTypes:global_stack_used, local_stack_used, trail_used, choice_used, heap,garbage
  % AccessType: random, first, last


/*
 Seeds.
1.    random(26010,5548,23873,425005073)
2.    random(28499,25560,28471,425005073)
3.    random(22138,25686,18390,425005073)
4.    random(5844,16882,29420,425005073)
5.    random(30131,26455,14300,425005073)
6.    random(25476,15079,18343,425005073)
7.    random(6107,20268,13873,425005073)
8.    random(8660,29600,25519,425005073)
9.    random(25009,13268,28234,425005073)
10.   random(8515,19614,3128,425005073)
*/ 

/*Rist table : Key:ordIdx -  Value:integer,atom,string und Size = 1 Million - gc off und gc on.*/

table1(GC,Seed,Size,KeyType,ValueType):-
        set_prolog_flag(gc,GC),
        setrand(Seed),
	format('~n Used Seed for Insert is ~w~n',[Seed]),
        datagenerator(KeyType,ValueType,Size,Keys,Values),
        format('~n Data is ready ~n',[]),
        acc(avl,time,Keys,Values,10,[],ResultAssert),
        geoMean(ResultAssert,MeanAssert),
        confi(ResultAssert,ConfiAssert),
        format('~n Assert  ~w Mean ~w Confi ~w ~n',[ResultAssert,MeanAssert,ConfiAssert]).

%Akkumulator.
acc(_,_,_,_,0,R,R).
acc(DatastructureType,Measurement,Keys,Values,X,Acc,Result):-
        insert(DatastructureType,Measurement,Keys,Values,R),
        clean(DatastructureType,Keys),
        Xnew is X-1,
        acc(DatastructureType,Measurement,Keys,Values,Xnew,[R|Acc],Result).

%T use the different Seeds.
seedIn([]).

seedIn([Seed|V]) :-
        tabelle1(on,Seed,10000,ordIdx,integer),
        seedIn(V).

%seedIn([random(26010,5548,23873,425005073),random(28499,25560,28471,425005073),random(22138,25686,18390,425005073), random(5844,16882,29420,425005073), random(30131,26455,14300,425005073), random(25476,15079,18343,425005073),random(6107,20268,13873,425005073),random(8660,29600,25519,425005073), random(25009,13268,28234,425005073), random(8515,19614,3128,425005073)]).

% ?- table1(off,random(26010,5548,23873,425005073),1000000,ordIdx,integer).










%Für die zweite Tabelle - Speicherauslastung beim einfügen von ordIdx-Integer - Quantity 100.000 - gc on, gc off.
tabelle2(X,GC,Seed,Global,Local,Trail,Heap,Garbage,Choice) :-
        set_prolog_flag(gc,GC),
        setrand(Seed),
	format('~n Used Seed for Insert is ~w~n',[Seed]),
        datagenerator(ordIdx,integer,1000000,Keys,Values),
        format('~n Data is ready ~n',[]),
        insert(X,global_stack_used,Keys,Values,Global),
                clean(X,Keys),
                clean,
        insert(X,local_stack_used,Keys,Values,Local), % Keine Unterschiede
        clean(X,Keys),        
        clean,              
        insert(X,trail_used,Keys,Values,Trail),
        clean,
        clean(X,Keys),
        insert(X,heap,Keys,Values,Heap),
        clean,
        clean(X,Keys),
        insert(X,garbage,Keys,Values,Garbage),
        clean,
        clean(X,Keys),
        insert(X,choice_used,Keys,Values,Choice),
        clean(X,Keys),
        clean.       %Hier vlt den Cut nach der Prozedur entfernen?

% tabelle2(X,on,random(26010,5548,23873,425005073),Global,Local,Trail,Heap,Garbage,Choice).


 %Für Balkendiagramme noch ordIdx-Atom und ordIdx-String in quantity 100.000 - gc-off
diagram(X,Seed,ValueType,Global,Trail,Heap) :-
        setrand(Seed),
	format('~n Used Seed for Insert is ~w~n',[Seed]),
        datagenerator(ordIdx,ValueType,100000,Keys,Values),
        format('~n Data is ready ~n',[]),
        insert(X,global_stack_used,Keys,Values,Global),
        clean(X,Keys),
        insert(X,trail_used,Keys,Values,Trail),
        clean(X,Keys),
        insert(X,heap,Keys,Values,Heap),
        clean(X,Keys).

% diagram(X,random(26010,5548,23873,425005073),atom,Global,Trail,Heap).
% diagram(X,random(26010,5548,23873,425005073),string,Global,Trail,Heap).


/* Für Grafik, die die Prozentualle Relation der Zeiten anzeigt, wenn anstelle von ordIdx, unordIdx und idxrev verwendet wird- gc off? */

%tabelle1(on,random(26010,5548,23873,425005073),100000,unordIdx,integer):-

% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,unordIdx,integer,Result).
% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,unordIdx,atom,Result).
% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,unordIdx,string,Result).

% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,revIdx,integer,Result).
% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,revIdx,atom,Result).
% tabelle1(Mean,Confi,assert,on,random(26010,5548,23873,425005073),100000,revIdx,string,Result).

/*
Schlüssel varieren, arrays ausgenommen.
Muss ich noch überlegen ob ich dafür zeit finde
*/


/*
Zugriff mit get. Alle Datenstrukturen und deshlab indexe als Schlüssel.
Zahle muss ich gucken, vlt 100.000 zu 20.000 oder so.
Alle Datenstrukturen:   ordIdx-Integer,          unordIdx-integer,                        revIdx-integer.
Zugriff random:          random                   random                                  random
Zugriff first:         zuerst hinzugefügt        kleinsteSchlüssel,random eingefügt     kleinste Schlüssel, zuletzt eingefügt
Zugriff last:          zuletzt hinzugefügt       größteSchlüsse, random eingefügt       größteschlüssel, zuerst eingefügt.
*/

tabelleGet(Mean,Confi,DatastructureType,GC,Seed,Size,ToGet,KeyType,AccessType,Result):-
        set_prolog_flag(gc,GC),
        setrand(Seed),
	format('~n Used Seed for Get is ~w~n',[Seed]),
        datagenerator(KeyType,integer,Size,Keys,Values),
        insertBack(DatastructureType,Keys,Values,Datastructure),
        setrand(Seed), 
	datagenerator(AccessType,Keys,ToGet,GetKeys),
        format('~n Data is ready ~n',[]),
        accGet(DatastructureType,time,GetKeys,Datastructure,10,[],Result),
        clean(DatastructureType,Keys),
        geoMean(Result,Mean),
        confi(Result,Confi).

accGet(_,_,_,_,0,R,R).
accGet(DatastructureType,Measurement,GetKeys,Datastructure,X,Acc,Result):-
        get(DatastructureType,Measurement,GetKeys,Datastructure,R,_Back),
        print(.),
        Xnew is X-1,
        accGet(DatastructureType,Measurement,GetKeys,Datastructure,Xnew,[R|Acc],Result).
 
% tabelleGet(Mean,Confi,assert,off,random(26010,5548,23873,425005073),10000,2500,ordIdx,random,Result).
/*
Zugriff mit update
*/
tabelleUpdate(Mean,Confi,DatastructureType,GC,Seed,Size,ToUpdate,KeyType,AccessType,Result):-
        set_prolog_flag(gc,GC),
        setrand(Seed),
	format('~n Used Seed for Get is ~w~n',[Seed]),
        datagenerator(KeyType,integer,Size,Keys,Values),
        insertBack(DatastructureType,Keys,Values,Datastructure),
        setrand(Seed),
	datagenerator(AccessType,Keys,ToUpdate,UpdateKeys),
        format('~n Data is ready ~n',[]),
	data(integer,ToUpdate,UpdateValues),
        accUpdate(DatastructureType,time,UpdateKeys,UpdateValues,Datastructure,10,[],Result),
        clean(DatastructureType,Keys),
        geoMean(Result,Mean),
        confi(Result,Confi).

accUpdate(_,_,_,_,_,0,R,R).
accUpdate(DatastructureType,Measurement,UpdateKeys,UpdateValues,Datastructure,X,Acc,Result):-
	update(DatastructureType,Measurement,UpdateKeys,UpdateValues,Datastructure,R),
        print(.),
        Xnew is X-1,
        accUpdate(DatastructureType,Measurement,UpdateKeys,UpdateValues,Datastructure,Xnew,[R|Acc],Result).
 
% tabelleUpdate(Mean,Confi,assert,on,random(26010,5548,23873,425005073),10000,5000,ordIdx,first,Result).


/*
Zugriff mit remove
*/
tabelleRemove(Mean,Confi,DatastructureType,GC,Seed,Size,ToRemove,KeyType,AccessType,Result):-
        set_prolog_flag(gc,GC),
        setrand(Seed),
	format('~n Used Seed for Get is ~w~n',[Seed]),
        datagenerator(KeyType,integer,Size,Keys,Values),
        setrand(Seed),
	datagenerator(AccessType,Keys,ToRemove,RemoveKeys),
        format('~n Data is ready ~n',[]),
        accRemove(DatastructureType,time,RemoveKeys,Keys,Values,10,[],Result),
        geoMean(Result,Mean),
        confi(Result,Confi).

accRemove(_,_,_,_,_,0,R,R).
accRemove(DatastructureType,Measurement,RemoveKeys,Keys,Values,X,Acc,Result):-
        insertBack(DatastructureType,Keys,Values,Datastructure),
	remove(DatastructureType,Measurement,RemoveKeys,Datastructure,R),
        subtract(Keys,RemoveKeys,H),
        clean(DatastructureType,H),
        print(.),
        Xnew is X-1,
        accRemove(DatastructureType,Measurement,RemoveKeys,Keys,Values,Xnew,[R|Acc],Result).


% tabelleRemove(Mean,Confi,assert,on,random(26010,5548,23873,425005073),1000,1000,ordIdx,first,Result).
