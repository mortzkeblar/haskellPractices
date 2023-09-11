% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipódromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipódromoSanIsidro, zona1, 1500).


% iterante/1: Se cumple para los festivales que ocurren en más de un lugar, 
% pero con el mismo nombre y las mismas bandas en el mismo orden.
careta(Festival).
iterante(Festival) :-
        festival(Festival, Bandas, UnLugar),
        festival(Festival, Bandas, OtroLugar),
        UnLugar \= OtroLugar.

% careta/1: Decimos que un festival es careta si no tiene campo o si es el personalFest.
careta(personalFest).
careta(Festival) :-
        festival(Festival, _, _),
        not(entradaVendida(Festival, campo)).

% nacAndPop/1: Un festival es nac&pop si no es careta y todas las bandas
% que tocan en él son de nacionalidad argentina y tienen popularidad mayor a 1000.
nacAndPop(Festival) :-
        festival(Festival, Bandas, _),
        not(careta(Festival)),
        forall(member(Banda, Bandas), (banda(Banda, argentina, Popularidad), Popularidad > 1000)).

% sobrevendido/1: Se cumple para los festivales que vendieron más 
% entradas que la capacidad del lugar donde se realizan.

sobrevendido(Festival) :-
        festival(Festival, _, Lugar),
        lugar(Lugar, Capacidad, _),
        findall(Entrada, entradaVendida(Festival, Entrada), Entradas),
        length(Entradas, Cantidad),
        Cantidad > Capacidad.

% recaudaciónTotal/2: Relaciona un festival con el total recaudado con 
% la venta de entradas. Cada tipo de entrada se vende a un precio diferente:
% - El precio del campo es el precio base del lugar donde se realiza
% el festival.
% - La platea general es el precio base del lugar más el plus que se
% aplica a la zona. 
% - Las plateas numeradas salen el triple del precio base para las filas
% de atrás (>10) y 6 veces el precio base para las 10 primeras filas.

precio(campo, Lugar, Precio) :-
        lugar(Lugar, _, Precio).

precio(plateaGeneral(Zona), Lugar, Precio) :- 
        lugar(Lugar, _, Base),
        plusZona(Lugar, Zona, Adicional),
        Precio is Base + Adicional.

precio(plateaNumerada(Numero), Lugar, Precio) :-
        Numero =< 10,
        lugar(Lugar, _, Base),
        Precio is Base * 6.


precio(plateaNumerada(Numero), Lugar, Precio) :-
        Numero > 10,
        lugar(Lugar, _, Base),
        Precio is Base * 3.


recaudacionTotal(Festival, Recaudacion) :-
        festival(Festival, _, Lugar),
        findall(Precio, (entradaVendida(Festival, Entrada), precio(Entrada, Lugar, Precio)), Precios),
        sumlist(Precios, Recaudacion).

% delMismoPalo/2: Relaciona dos bandas si tocaron juntas en algún 
% recital o si una de ellas tocó con una banda del mismo palo que la otra,
% pero más popular.
 
tocoCon(Banda, OtraBanda) :-
        festival(_, Bandas, _),
        member(Banda, Bandas),
        member(OtraBanda, Bandas),
        Banda \= OtraBanda. 

delMismoPalo(Banda, OtraBanda) :-
        tocoCon(Banda, OtraBanda).

delMismoPalo(Banda, OtraBanda) :-
        tocoCon(Banda, TercerBanda),
        banda(OtraBanda, _, OtraPopularidad),
        banda(TercerBanda, _, TercerPopularidad),
        TercerPopularidad > OtraPopularidad, 
        delMismoPalo(TercerBanda, OtraBanda).
