% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

%Consult database
:- consult('database.pl').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicates to test for inheritence %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% wrapper to add itself to list
wrapertestIsa(X,[X|Isalist]):-
testForisa(X, Isalist).

% "is a" base case
testForisa(thing, []).

% predicate to find al parents from X
testForisa(X, [Y|IsaList]):-
isa(X, Y),
testForisa(Y, IsaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number restriction predicates  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicates to find al associated features

% "has a" base case
testForHasa([],[]).

% predicate to check for all features of the animals in the list
% takes as input what is returned from the is a predicate
testForHasa([NewAnimal|NewIsaList], HasaList):-
findall(Feature:Lower:Uper, hasa(NewAnimal,Feature,Lower,Uper), InheritedHasaList),
testForHasa(NewIsaList, NewHasaList),
append(NewHasaList,InheritedHasaList, HasaList).

% Predicate to check if certain animal has a certain feature, described in the predicate
% by the variable Feature
hasall(Animal,Feature,Lower,Upper):-
wrapertestIsa(Animal,P),
testForHasa(P,Q),
member(Feature:Lower:Upper,Q).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predicates to get animals by features%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gets all animals with a certain feature with the value of Lower and Upper
% We know this does not take in account that certain features may match if the 
% are in range with the feature, this predicate does only returns the feature if 
% the lower and upper match exactly.
getAnimals([Feature:Lower:Upper],AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), AnimalList).

getAnimals([Feature:Lower:Upper|FeatureList], AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), NewAnimalList),
getAnimals(FeatureList, TotalAnimalList),
intersection(TotalAnimalList,NewAnimalList,AnimalList).



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Value restriction tests %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicates to find al associated featuresi

% Hasa Value base case
testForHasaValue([],[]).

% Predicate to find all value restrictions associated with the animal list generated
% by the "is a predicat".
testForHasaValue([NewAnimal|NewIsaList], HasaList):-
findall(Feature:Value, valueHasa(NewAnimal,Feature,Value), InheritedHasaList),
testForHasaValue(NewIsaList, NewHasaList),
append(NewHasaList,InheritedHasaList, HasaList).

% Predicate to check if a certain animal has a certain Value restriction
hasallValue(Animal,Feature,Value):-
wrapertestIsa(Animal,P),
testForHasaValue(P,Q),
member(Feature:Value,Q).

% predicate to get animals by features
% These predicates return a the animals with a certain value reestriction
getAnimalsValue([Feature:Value],AnimalList):-
findall(Animal, hasallValue(Animal,Feature,Value), AnimalList).

getAnimalsValue([Feature:Value|FeatureList], AnimalList):-
findall(Animal, hasallValue(Animal,Feature,Value), NewAnimalList),
getAnimalsValue(FeatureList, TotalAnimalList),
intersection(TotalAnimalList,NewAnimalList,AnimalList).
%append(TotalAnimalList,NewAnimalList, AnimalList



%%%%%%%%%%%%%%
% Classifier %
%%%%%%%%%%%%%%

% Classifier for num restricitons
classifier([NumRes:Lower:Upper|NumAni],X):-
getAnimals([NumRes:Lower:Upper|NumAni],X).

% Classifier for val restricitions
classifier([ValRes:Val|ValAni],X):-
getAnimalsValue([ValRes:Val|ValAni],X).

% Classifier for both val and num restricitons
classifier([NumRes:Lower:Upper|NumAni],[ValRes:Val|ValAni],X):-
getAnimals([NumRes:Lower:Upper|NumAni],NumAnimals),
getAnimalsValue([ValRes:Val|ValAni],ValAnimals),
intersection(NumAnimals,ValAnimals,X).

% Intersection function
% Source: http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_7.html
intersection([X|Y],M,[X|Z]) :- member(X,M), intersection(Y,M,Z).
intersection([X|Y],M,Z) :- \+ member(X,M), intersection(Y,M,Z).
intersection([],M,[]).

