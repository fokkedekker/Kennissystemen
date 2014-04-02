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
hasa(dolphin,3,nil).

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

getAnimals([],[]).

getAnimals([Feature:Lower:Upper|FeatureList], AnimalList):-
findall(Animal, hasa(Animal,Feature,Lower,Upper), NewAnimalList),
getAnimals(FeatureList, TotalAnimalList),
append(TotalAnimalList,NewAnimalList, AnimalList).

