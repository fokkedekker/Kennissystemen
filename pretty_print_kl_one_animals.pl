% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

% Import all needed files
:- consult('kl-one_annimals.pl').


show:-
	findall(Y, isa(Y,X), All),
	print(All),
	print('\n'),
	show2(All).


show2(All):-
	All=[First|Rest],
	wrapertestIsa(First, X),
	X=[SameAnimal|Parents],
	inheritanceprinter(First, Parents).

inheritanceprinter(Child, []).

inheritanceprinter(Child, [Parent|RestParents]):-	
	print(Child),
	print(' is as subsummee of: \n'),
	print(Parent),
	print('       \n'),
	inheritanceprinter(Child, RestParents).



featureprinter(Animal):-
	testForHasa([Animal], Features),
	featureprint(Features).
%featureprinter(Animal).

%featureprint([]):-
%	print('\n').
featureprint([Feature:Lower:Upper|RestFeatures]):-
	print('\n     has between '),
	print(Lower),
	print(' and '),
	print(Upper),
	print(' '),
	print(Feature),
	print(' \n').
	featureprint(RestFeatures).
