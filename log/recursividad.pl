factorial(0, 1).
factorial(N, F) :-
	Anterior is N-1,
	factorial(Anterior, F2), F is F2*N.

ultimo([X], X).
ultimo([_|Cola], Ultimo) :-
	ultimo(Cola, Ultimo).
