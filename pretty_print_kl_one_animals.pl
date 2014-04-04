% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

% Import all needed files
:- consult('kl-one_annimals.pl').




show2(All):-
	All=[First|Rest],
	wrapertestIsa(First, X),
	X=[SameAnimal|Parents],
	print(First),
	print('\n'),
	inheritanceprinter(First, Parents),
	print('     ----------Number restrictions'),
	featureprinter(First),
	show2(Rest).

show3(All):-
	All=[First|Rest],
	wrapertestIsa(First,X),
	X=[SameAnimal|Parents],
	print(First),
	print('\n'),
	inheritanceprinter(First,Parents),
	print('     ----------Value restrictions'),
	featureprinterValue(First),
	show3(Rest).

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

featurePrintValue([]):-
	print('\n').

featurePrintValue([Feature:Value|RestFeatures]):-
	print('\n has a '),
	print(Feature),
	print('of value '),
	print(Value),
	print('\n'),
	print('\n').



featureprinterValue(Animal):-
wrapertestIsa(Animal,ListofAnimals),
testForHasaValue(ListofAnimals,ListOfFeatures),
featurePrintValue(ListOfFeatures).

show:-
	findall(Y, isa(Y,X), All),
	print(All),
	print('\n'),
	show2(All),
	show3(All).
:- show.

