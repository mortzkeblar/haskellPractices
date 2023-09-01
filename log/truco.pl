% 1 de basto mata 7 de espada
% 1 de basto no mata 1 de espada
% 4 de cualquier palo no mata

% mata no inversible
mata(carta(3, oro), carta(2, copa)).
mata(carta(1, basto), carta(7, espada)).
mata(carta(7, espada), carta(7, oro)).

mata(carta(7, oro), carta(3, _)).
mata(carta(3, _), carta(2, _)).

mata(carta(2, _), As) :- falsoAs(As).
falsoAs(carta(1, oro)).
falsoAs(carta(1, copa)).

% solucion a inversibilidad


valeMas(carta(3, oro), carta(2, copa)).
valeMas(carta(1, basto), carta(7, espada)).
valeMas(carta(7, espada), carta(5, oro)).

valeMas(carta(5, oro), carta(3, _)).
valeMas(carta(3, _), carta(2, _)).

%suponemos que tanto palo como numeroValioso estan definidos y son inversibles
cartaDeTruco(carta(Numero, Palo)) :-
	palo(Palo),
	numeroValido(Numero).

palo(basto).
palo(copa).
palo(oro).
palo(espada).

numeroValido(Numero) :-
	between(1, 12, Numero),
	not(between(8, 9, Numero)).

mata1(MasValiosa, MenosValiosa) :-
	cartaDeTruco(MasValiosa),
	cartaDeTruco(MenosValiosa),
	% valeMas no es totalmente inversible pero estamos asegurando
	% que le llegen valores individuales al predicado, entonces
	% mata es inversible
	valeMas(MasValiosa, MenosValiosa).


mata1(MasValiosa, MenosValiosa) :-
	cartaDeTruco(MasValiosa),
	cartaDeTruco(OtraCarta),
	valeMas(MasValiosa, OtraCarta),
	mata1(OtraCarta, MenosValiosa).
