:- module(statistics,[prodOfList/2,geoMean/2,sumOfList/2,standDev/2,confi/2]).

:- use_module(datastructures).

prodOfList(List,R):-
	prodOfList(List,1,R).

prodOfList([],R,R).

prodOfList([H|T],X,R):-
        Helper is H * X,
        prodOfList(T,Helper,R).
        
sumOfList(List,R):-
	sumOfList(List,0,R).

sumOfList([],R,R).

sumOfList([H|T],X,R):-
        Helper is H + X,
        sumOfList(T,Helper,R).

geoMean(List,R) :-
        prodOfList(List,H),
        length(List,X),
        R is (exp(H,(1/X))).
       
       
standDev(List,R) :-
        geoMean(List,GeoMean),
	standDev(List,GeoMean,[],R2),
	sumOfList(R2,R3),
	length(List,X),
        Helper is (R3*(1/X)),
	R is ( exp( Helper,(1/2))).       
       
standDev([],_,R,R).

standDev([H|T],GeoMean,Acc,R) :-
	Helper is ((H-GeoMean)*(H-GeoMean)),
	standDev(T,GeoMean,[Helper|Acc],R).
	
%0.95 Konfidenzintervall 
confi(List,R):-
        standDev(List,StandDev),
        length(List,X),
        R is (2.262*(StandDev/(exp(X,(1/2))))).

