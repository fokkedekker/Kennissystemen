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

wrapertestIsa(X,[X|Isalist]):-
testForisa(X, Isalist).

testForisa(thing, []).

testForisa(X, [Y|IsaList]):-
isa(X, Y),
testForisa(Y, IsaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number restriction predicates  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predicates to get animals by features%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getAnimals([Feature:Lower:Upper],AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), AnimalList).

getAnimals([Feature:Lower:Upper|FeatureList], AnimalList):-
findall(Animal, hasall(Animal,Feature,Lower,Upper), NewAnimalList),
getAnimals(FeatureList, TotalAnimalList),
intersection(TotalAnimalList,NewAnimalList,AnimalList).



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Value restriction tests %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicates to find al associated features
testForHasaValue([],[]).

testForHasaValue([NewAnimal|NewIsaList], HasaList):-
findall(Feature:Value, valueHasa(NewAnimal,Feature,Value), InheritedHasaList),
testForHasaValue(NewIsaList, NewHasaList),
append(NewHasaList,InheritedHasaList, HasaList).

hasallValue(Animal,Feature,Value):-
wrapertestIsa(Animal,P),
testForHasaValue(P,Q),
member(Feature:Value,Q).

% predicate to get animals by features
getAnimalsValue([Feature:Value],AnimalList):-
findall(Animal, hasallValue(Animal,Feature,Value), AnimalList).

getAnimalsValue([Feature:Value|FeatureList], AnimalList):-
findall(Animal, hasallValue(Animal,Feature,Value), NewAnimalList),
getAnimalsValue(FeatureList, TotalAnimalList),
intersection(TotalAnimalList,NewAnimalList,AnimalList).
%append(TotalAnimalList,NewAnimalList, AnimalList).

checkFeaturesValue([],_).

checkFeaturesValue([Feature:Value|FeatureList],ReturnAnimalList):-
getAnimalsValue([Feature:Value],Relephant),
intersection(Relephant,ReturnAnimalList,CheckedReturnList),
checkFeaturesValue(FeatureList,CheckedReturnList).

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

