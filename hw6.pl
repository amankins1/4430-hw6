% Alex Mankins

:- use_module(lambda).
%Uses Lambda module from http://www.swi-prolog.org/pack/list?p=lambda

hw6 :-
	solve(Moves),
	printmoves(Moves, [0]).

solve(Moves) :-
	try([0], [1,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves).
	
% These are the moves to solve it.
% After I got it to work I went through and tested each move
% to see if it was necissary and commented it out if it was
% not to make it a little more efficient. 
move(B,1,E) :-member([B,E], [[3,0], [0,3]]).
move(B,2,E) :-member([B,E], [[5,0], [0,5]]).
move(B,3,E)	:-member([B,E], [[6,1], [1,6]]).
move(B,5,E)	:-member([B,E], [[9,2], [2,9]]).
move(B,4,E)	:-member([B,E], [[5,3], [3,5]]).
move(B,7,E)	:-member([B,E], [[11,4], [4,11]]).
move(B,8,E)	:-member([B,E], [[12,5], [5,12]]).
move(B,9,E)	:-member([B,E], [[14,5], [5,14]]).
move(B,11,E):-member([B,E], [[12,10], [10,12]]).
move(B,12,E):-member([B,E], [[13,11], [11,13]]).
%move(B,4,E):-member([B,E], [[8,1], [1,8]]).
%move(B,4,E):-member([B,E], [[7,2], [2,7]]).
%move(B,6,E):-member([B,E], [[10,3], [3,10]]).
%move(B,7,E):-member([B,E], [[12,3], [3,12]]).
%move(B,8,E):-member([B,E], [[13,4], [4,13]]).
%move(B,7,E):-member([B,E], [[6,8], [8,6]]).
%move(B,8,E):-member([B,E], [[7,9], [9,7]]).
%move(B,13,E):-member([B,E], [[12,14], [14,12]]).


try(_, [_], Lst, Moves) :-
	reverse(Lst, Moves).

try(Free, Occupied, Lst, Moves) :-
	select(B, Occupied, Oc1),
	select(O, Oc1, Oc2),
	select(E, Free, F1),
	move(B, O, E),
	try([B, O | F1], [E | Oc2], [move(B,O,E) | Lst], Moves).

printmoves([], Free) :-
	numlist(0,14, Lst),
	maplist(\X^I^(member(X, Free) -> I = 'O'; I = 'X'),Lst,[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w~n',			[I1]),
	format('   ~w ~w~n',		[I2,I3]),
	format('  ~w ~w ~w~n',		[I4,I5,I6]),
	format(' ~w ~w ~w ~w~n',	[I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n',	[I11,I12,I13,I14,I15]).


printmoves([move(Start, Middle, End) | Tail], Free) :-
	numlist(0,14, Lst),
	maplist(\X^I^(member(X, Free) -> I = 'O'; I = 'X'),Lst,[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w~n',			[I1]),
	format('   ~w ~w~n',		[I2,I3]),
	format('  ~w ~w ~w~n',		[I4,I5,I6]),
	format(' ~w ~w ~w ~w~n',	[I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n',	[I11,I12,I13,I14,I15]),
	select(End, Free, F1),
	printmoves(Tail,  [Start, Middle | F1]).