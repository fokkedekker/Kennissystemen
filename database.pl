% Database for KL-ONE-Animals.pl 
% Jonas Lodewegen (10203745)
% Menno van Leeuwen (10280588)
% Fokke Dekker (10264256)
% Practicum opdracht 1
% maart 2014

%Generic concepts
isa(animal, thing).
isa(mammal, animal).
isa(fish, animal).
isa(reptile, animal).

isa(feline, mammal).
isa(cat, feline).
isa(lion, feline).

isa(bat, mammal).
isa(mouse, mammal).
isa(dolphin, mammal).
isa(elephant, mammal).

isa(croc, reptile).
isa(snake, reptile).

isa(gold-fish, fish).

% Relations
% ---------

% Heterotrophic
hasa(animal, heterotrophic).

% Endothermic
hasa(mammal, endothermic).

% Wings
hasa(bird, wing, 2, 2).
hasa(bat, wing, 2, 2).

% Legs
hasa(feline, leg, 4, 4).
hasa(bird, leg, 2, 2).
hasa(elephant, leg, 4, 4).
hasa(croc, leg, 4, 4).
hasa(bat, leg, 2, 2).
hasa(mouse, leg, 2, 2).

% Tails
hasa(feline, tail , 1, 1).
hasa(reptile, tail , 1, 1).
hasa(gold-fish, tail , 1, 1).
hasa(dolphin, tail , 1, 1).
hasa(elephant, tail, 1, 1).

% Gills
hasa(fish,gills,1,nil).
hasa(gold-fish,gills,2,nil).

% Fins
hasa(gold-fish, fins,3,nil).
hasa(dolphin,fins,3,nil).

% Value restrictions
valueHasa(lion,colour,yellow).
val