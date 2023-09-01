import TestCarreras
import Text.Show.Functions

{-

Carreras

Queremos armar un programa que nos permita simular unas fantásticas carreras de autos en las cuales
cada vehículo avanza tan rápido como puede para consagrarse campeón, aprovechando del uso de algunos poderes
especiales (o power ups) que encuentren a lo largo del trayecto para sacar ventaja por sobre los demás autos.

De cada auto conocemos su color (que nos servirá para identificarlo durante el desarrollo de la carrera),
la velocidad a la que está yendo y la distancia que recorrió, ambos valores de tipo entero.

De la carrera sólo nos interesa el estado actual de los autos que están participando, lo cual nos 
permitirá analizar cómo viene cada uno, y posteriormente procesar aquellos eventos que se den en
la carrera para determinar el resultado de la misma.

Teniendo en cuenta lo descrito anteriormente se pide resolver los siguientes puntos explicitando el tipo
de cada función desarrollada y utilizando los conceptos aprendidos del Paradigma Funcional, poniendo
especial énfasis en el uso de Composición, Aplicación Parcial y Orden Superior.

-}

{-

Declarar los tipos Auto y Carrera como consideres convenientes para representar la información indicada
y definir funciones para resolver los siguientes problemas:

a) Saber si un auto está cerca de otro auto, que se cumple si son autos distintos y la distancia que
hay entre ellos (en valor absoluto) es menor a 10.

b) Saber si un auto va tranquilo en una carrera, que se cumple si no tiene ningún auto cerca y les
va ganando a todos (por haber recorrido más distancia que los otros).

c) Conocer en qué puesto está un auto en una carrera, que es 1 + la cantidad de autos de la carrera
que le van ganando.

-}


modulo :: Int -> Int -> Int
modulo x y
        | x - y > 0 = x - y 
        | otherwise = - (x - y)

colorDistinto :: Auto -> Auto -> Bool
colorDistinto auto = (/= color auto) . color

distanciaMenorA10 :: Auto -> Auto -> Bool
distanciaMenorA10 auto = (< 10) . modulo (distancia auto) . distancia

dosAutosCerca :: Auto -> Auto -> Bool
dosAutosCerca auto1 auto2 = colorDistinto auto1 auto2 && distanciaMenorA10 auto1 auto2 

primerLugar :: Auto -> Carrera -> Bool
primerLugar auto = all (<= distancia auto) . map distancia

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = primerLugar auto carrera &&  all (not . dosAutosCerca auto) carrera

puesto :: Auto -> Carrera -> Int
puesto _ [] = 0
puesto auto (x:xs)
        | distancia auto <= distancia x = 1 + puesto auto xs
        | otherwise = puesto auto xs


{-

Desarrollar las funciones necesarias para manipular el estado de los autos para que sea posible:

a) Hacer que un auto corra durante un determinado tiempo. Luego de correr la cantidad de tiempo indicada,
la distancia recorrida por el auto debería ser equivalente a la distancia que llevaba 
recorrida + ese tiempo * la velocidad a la que estaba yendo.


b1) A partir de un modificador de tipo Int -> Int, queremos poder alterar la velocidad de un auto
de modo que su velocidad final sea la resultante de usar dicho modificador con su velocidad actual.

b2) Usar la función del punto anterior para bajar la velocidad de un auto en una cantidad indicada
de modo que se le reste a la velocidad actual la cantidad indicada, y como mínimo quede en 0,
ya que no es válido que un auto quede con velocidad negativa.

-}

corra :: Auto -> Int -> Auto
corra auto tiempo = auto {
        distancia = distancia auto + tiempo * velocidad auto
}


alterarVelocidad :: (Int -> Int) -> Auto -> Auto 
alterarVelocidad modif auto = auto {
        velocidad = modif (velocidad auto)
}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad bajar auto
      | velocidad (alterarVelocidad (flip (-) bajar) auto) > 0 = alterarVelocidad (flip (-) bajar) auto
      | otherwise = auto {velocidad = 0}

{-

Como se explicó inicialmente sobre las carreras que queremos simular, los autos que participan
pueden gatillar poderes especiales a los que denominamos power ups.
Estos poderes son variados y tienen como objetivo impactar al estado general de la carrera,
ya sea afectando al auto que lo gatilló y/o a sus contrincantes dependiendo de qué poder se trate.

Nota: disponemos de una función afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
que puede ser de utilidad para manipular el estado de la carrera. Ver pág. 2 para más detalles.

Inicialmente queremos poder representar los siguientes power ups, pero debería ser fácil incorporar
más power ups a futuro para enriquecer nuestro programa:

a) terremoto: luego de usar este poder, los autos que están cerca del que gatilló el power up
bajan su velocidad en 50.

b) miguelitos: este poder debe permitir configurarse con una cantidad que indica en cuánto deberán 
bajar la velocidad los autos que se vean afectados por su uso. Los autos a afectar son aquellos a
los cuales el auto que gatilló el power up les vaya ganando.

c) jet pack: este poder debe afectar, dentro de la carrera, solamente al auto que gatilló el poder.

El jet pack tiene un impacto que dura una cantidad limitada de tiempo, el cual se espera poder configurar.
Cuando se activa el poder del jet pack, el auto afectado duplica su velocidad actual, luego corre
durante el tiempo indicado y finalmente su velocidad vuelve al valor que tenía antes de que se active
el poder.

Por simplicidad, no se espera que los demás autos que participan de la carrera también avancen en ese tiempo.

-}

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not . criterio) lista

--powerups :: (a -> Bool) -> (a -> a) -> Carrera -> Carrera
--powerups condicion efecto = afectarALosQueCumple condicion efecto

terremoto :: Auto -> Carrera -> Carrera
terremoto auto = afectarALosQueCumplen (dosAutosCerca auto) (bajarVelocidad 50) 

miguelitos :: Int -> Auto -> Carrera -> Carrera
miguelitos x auto = afectarALosQueCumplen ()
