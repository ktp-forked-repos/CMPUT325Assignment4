/*
CMPUT 325 Assignment 4
Author: Blaz Pocrnja
Student ID: 1472712
*/

:- use_module(library(clpfd)).

/*	Question 1
*/
fourSquares(N, [S1, S2, S3, S4]) :- 
	Vars = [S1, S2, S3, S4],
	Vars ins 0..sup,
	N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
	S1 #=< S2, S2 #=< S3, S3 #=< S4,
	label([S1, S2, S3, S4]).


/*	Question 2
*/
disarm([],[],[]).
disarm(Adivisions, Bdivisions, Solution) :- 
	Solution = [ThisMonth, NextMonth | Rest],
	ThisMonth = [ThisA, ThisB],
	NextMonth = [NextA, NextB],

	Lengths = [ALen, BLen, NALen, NBLen],
	Lengths ins 1..2,
	ALen #\= BLen,
	NALen #\= NBLen,
	length(ThisA, ALen), 
	length(ThisB, BLen),
	length(NextA, NALen), 
	length(NextB, NBLen),

	list_sum(ThisA, Sum1),
	list_sum(ThisB, Sum2),
	list_sum(NextA, Sum3),
	list_sum(NextB, Sum4),
	Sum1 #= Sum2,
	Sum3 #= Sum4,
	Sum1 #=< Sum3,

	subset(ThisA, Adivisions),
	subset(ThisB, Bdivisions),

	subtract_once(Adivisions, ThisA, NextAdiv),
	subtract_once(Bdivisions, ThisB, NextBdiv),

	subset(NextA, NextAdiv),
	subset(NextB, NextBdiv),

	subtract_once(NextAdiv, NextA, RestAdiv),
	subtract_once(NextBdiv, NextB, RestBdiv),

	disarm(RestAdiv, RestBdiv, Rest).





	
	/*
	Solution = [ThisMonth | Rest],
	ThisMonth = [AMonth, BMonth],
	Rest = [[AMonth2, _] | _],

	[ALen, BLen] ins 1..2,
	ALen #\= BLen,
	length(AMonth, ALen), 
	length(BMonth, BLen),

	subset(AMonth, Adivisions),
	subset(BMonth, Bdivisions),

	list_sum(AMonth, Sum1),
	list_sum(BMonth, Sum2),
	Sum1 #= Sum2,
	list_sum(AMonth2, Sum3), 
	Sum1 #=< Sum3,
	

	subtract_once(Adivisions, AMonth, NextA),
	subtract_once(Bdivisions, BMonth, NextB),
	subset(AMonth2, NextA),
	disarm(NextA, NextB, Rest).
	*/

list_sum([Item], Item).
list_sum([Item1,Item2 | Tail], Total) :-
    list_sum([Item1+Item2|Tail], Total).

subtract_once(List, [], List).
subtract_once(List, [Item|Delete], Result):-
  (select(Item, List, NList)->
    subtract_once(NList, Delete, Result);
    (List\=[],subtract_once(List, Delete, Result))).