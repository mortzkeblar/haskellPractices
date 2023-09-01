gustan(juan, maria).
gustan(pedro, ana).
gustan(pedro, nora).

gustan(P, zulema):- gustan(P, nora).

gustan(julian, Chica):- chica(Chica), morocha(Chica).
gustan(julian, Chica):- chica(Chica), tieneOnda(Chica).

gustan(mario, Chica):- chica(Chica), morocha(Chica), tieneOnda(Chica).
gustan(mario, luisa).

gustan(P, laura):- gustan(P, luisa), gustan(P, ana).

