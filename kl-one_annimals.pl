% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

%Generic concepts
isa(animal, thing).
isa(mammal, animal).
isa(nonMammal, animal).

isa(feline, mammal).
isa(cat, feline).
isa(lion, feline).

isa(bat, mammal).
isa(mouse, mammal).
isa(dolphin, mammal).
isa(elephant, mammal).

isa(gold-fish, nonMammal).

isa(reptile, nonMammal).
isa(croc, reptile).
isa(snake, reptile).

% Relations
hasa(bird,wing,2,2).
hasa(bat,wing,2,2).

% Legs
hasa(feline,leg,4,4).
hasa(bird,leg,2,2).
hasa(elephant,leg,4,4).
hasa(croc,leg,4,4).
hasa(bat,leg,2,2).
hasa(mouse,leg,2,2).

% tails
hasa(feline,tail,1,1).
hasa(reptile,tail,1,1).
hasa(gold-fish,tail,1,1).
hasa(dolphin,tail,1,1).
hasa(elephant,tail,1,1).

% gills
hasa(gold-fish,gills,2,nil).

% finss
hasa(gold-fish, fin,3,nil).
hasa(dolphin,fin,3,nil).

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
