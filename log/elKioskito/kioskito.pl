% base de conocimientos

atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

% Punto 1: calentando motores
atiende(vale, Dia, Entrada, Salida) :- atiende(dodain, Dia, Entrada, Salida).
atiende(vale, Dia, Entrada, Salida) :- atiende(juanC, Dia, Entrada, Salida).
/* si nadie hace el horario de juanC, entonces no necesitamos declarar nada. Ya que por el principio de universo cerrado, lo que no este en la base de conocimientos
se considera falso. Asi tambien con maiu, si desconocemos la accion, entonces se asume que es falso. */

% Punto 2: quien atiende el kiosko
quienAtiende(Persona, Dia, Hora) :- 
	atiende(Persona, Dia, A, B),
	between(A, B, Hora).

% Punto 3: forever alone
foreverAlone(Persona, Dia, Horario) :- 
	quienAtiende(Persona, Dia, Horario),
	not((quienAtiende(OtraPersona, Dia, Horario), Persona \= OtraPersona)).

% Punto 4: posibilidad de atencion
posibilidadDeAtencion(Dia) :-
	quienAtiende(_, Dia, _),
	forall(quienAtiende(Persona, Dia, Hora), quienAtiende(Persona, Dia, Hora)).
