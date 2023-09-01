dulce(chocolate).
dulce(caramelo).
dulce(durazno).

amargo(radicheta).
amargo(cebada).

leGusta(roque,chocolate).
leGusta(roque,radicheta).
leGusta(pepe,cebada).
leGusta(juan, chocolate).
leGusta(juan, caramelo).
leGusta(marcos, caramelo).
leGusta(marcos, chocolate).
leGusta(marcos, durazno).

colorDePelo(roque,colorado).
colorDePelo(pepe,castanio).

vive(roque,buenosAires).
vive(pepe,mendoza).
vive(lucas,salliquelo).

ciudadGrande(buenosAires).
ciudadGrande(mendoza).

/*
persona(roque).
persona(juan).
persona(pepe). 
persona(lucas).
*/

esTierno(Persona) :- 
	leGusta(Persona, _), 
	forall(leGusta(Persona, Alimento), dulce(Alimento)).

%alimentoCurioso(A) :- forall(leGusta(P, A), esColorado(P)).

nicer(X) :- forall(between(1, X, Y), print(Y)).

siguiente(N, S) :-
	numero(N),
	S is N + 1.
