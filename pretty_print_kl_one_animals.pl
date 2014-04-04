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
	print(First),
	print('\n'),
	inheritanceprinter(First, Parents),
	print('     -----------FEATURES'),
	featureprinter(First),
	show2(Rest).

inheritanceprinter(Child, []).

inheritanceprinter(Child, [Parent|RestParents]):-	
	print('     is as subsummee of: '),
	print(Parent),
	print('       \n'),
	inheritanceprinter(Child, RestParents).




featureprinter(Animal):-
	wrapertestIsa(Animal, ListofAnimals),
	%print(ListofAnimals),
	testForHasa(ListofAnimals, ListofFeatures),
	%print(ListofFeatures),
	featureprint(ListofFeatures).
%featureprinter(Animal).

featureprint([]):-
	print('\n').
featureprint([Feature:Lower:Upper|RestFeatures]):-
	print('\n     has between '),
	print(Lower),
	print(' and '),
	print(Upper),
	print(' '),
	print(Feature),
	featureprint(RestFeatures).
