% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

%Consult database
:- consult('database.pl').

% Predicates to test for inheritence
wrapertestIsa(X,[X|Isalist]):-
testForisa(X, Isalist).

testForisa(thing, []).

testForisa(X, [Y|IsaList]):-
isa(X, Y),
testForisa(Y, IsaList).

% Predicates to find al associated features
testForHasa([],[]).

testForHasa([NewAnimal|NewIsaList], HasaList):-
findall(Feature:Lower:Uper, hasa(NewAnimal,Feature,Lower,Uper), InheritedHasaList),
testForHasa(NewIsaList, NewHasaList),
append(NewHasaList,InheritedHasaList, HasaList).

hasall(Animal,Feature,Lower,Upper):-
wrapertestIsa(Animal,P),
testForHasa(P,Q),
member(Feature:Lower:Upper,Q).




% predicate to get animals by features
getAnimals([Feature:Lower:Upper],AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), AnimalList).

getAnimals([Feature:Lower:Upper|FeatureList], AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), NewAnimalList),
getAnimals(FeatureList, TotalAnimalList),
intersection(TotalAnimalList,NewAnimalList,AnimalList).
%append(TotalAnimalList,NewAnimalList, AnimalList).

checkFeatures([],_).

checkFeatures([Feature:Lower:Upper|FeatureList],ReturnAnimalList):-
getAnimals([Feature:Lower:Upper],Relephant),
intersection(Relephant,ReturnAnimalList,CheckedReturnList),
checkFeatures(FeatureList,CheckedReturnList).



% Intersection function
% Source: http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_7.html
intersection([X|Y],M,[X|Z]) :- member(X,M), intersection(Y,M,Z).
intersection([X|Y],M,Z) :- \+ member(X,M), intersection(Y,M,Z).
intersection([],M,[]).

intersect([],_,[]).
intersect([X|L],Set,[X|Z]):-
member(X,Set),!,
intersect(L,Set,Z).
intersect([X|L],Set,Z):-
not(member(X,Set)),
intersect(L,Set,Z).
