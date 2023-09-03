canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

% Para comenzar el concierto, es preferible introducir primero a los cantantes más
% novedosos, por lo que necesitamos un predicado para saber si un vocaloid es novedoso
% cuando saben al menos 2 canciones y el tiempo total que duran todas las canciones debería ser
% menor a 15.

novedoso(Cantante) :-
	sabeAlMenosDosCanciones(Cantante),
	tiempoTotalDeCanciones(Cantante, Tiempo),
	Tiempo < 15.

% sabeAlMenosDosCanciones(Cantante) :-
% 	canta(Cantante, Cancion),
% 	canta(Cantante, OtraCancion),
% 	Cancion \= OtraCancion.

totalCantidadDeCanciones(Cantante, CancionesTotal) :-
	findall(Cancion, canta(Cantante, cancion(Cancion, _)), ListaCanciones),
	sum_list(ListaCanciones, CancionesTotal).

totalTiempoDeCanciones(Cantante, TiempoTotal) :-
	findall(Minutos, canta(Cantante, cancion(_, Minutos)), ListaMinutos),
	sum_list(ListaMinutos, TiempoTotal).

% Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no
% les gusta, es por eso que se pide saber si un cantante es acelerado, condición que
% se da cuando todas sus canciones duran 4 minutos o menos. Resolver sin usar forall/2.

acelerado(Cantante) :-
	canta(Cantante, _),
	% forall(canta(Cantante, cancion(_, Minutos)), Minutos =< 4).
	not((canta(Cantante, cancion(_, Minutos)), not(Minutos =< 4))).

% concierto(Nombre, Pais, CantidadDeFama, TipoDeConcierto)

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequeno(4)).

puedeParticipar(Cantante, Concierto) :-
	canta(Cantante, Canciones),
	totalCantidadDeCanciones(Cantante, CancionesTotales),
	
	
