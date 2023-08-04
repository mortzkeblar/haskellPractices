import Golf
import Text.Show.Functions

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro {
	velocidad = 10,
	precision = precisionJugador habilidad * 2,
	altura = 0
}

madera :: Palo
madera habilidad = UnTiro {
	velocidad = 100,
	precision = precisionJugador habilidad `div` 2,
	altura = 5
}

hierro :: Int -> Palo
hierro n habilidad = UnTiro {
	velocidad = fuerzaJugador habilidad * n,
	precision = precisionJugador habilidad `div` n,
	altura = (n - 3) `max` 0
}

palos :: [Palo]
palos = [putter, madera] ++ map hierro [1 .. 10]

-- Definir la función golpe que dados una persona y un palo, 
-- obtiene el tiro resultante de usar ese palo con las habilidades de la persona. 
-- Por ejemplo si Bart usa un putter, se genera un tiro de velocidad = 10, precisión = 120 y altura = 0.

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = (palo . habilidad) jugador

golpe' :: Palo -> Jugador -> Tiro
golpe' palo = palo . habilidad

golpe'' :: Jugador -> Palo -> Tiro
golpe'' jugador palo = palo (habilidad jugador)


-- OBSTACULO SUPERABLE 

data Obstaculo = Obstaculo {
	puedeSuperar :: Tiro -> Bool,
	efectoSuperar :: Tiro -> Tiro
} 

{-
obstaculoSuperable :: (Tiro -> Bool) -> (Tiro -> Tiro) -> Tiro -> Tiro
obstaculoSuperable condicion efecto tiro 
	| condicion tiro = efecto tiro
	| otherwise = tiroDetenido
-}

intentarSuperar :: Obstaculo -> Tiro -> Tiro
intentarSuperar obstaculo tiro
	| puedeSuperar obstaculo tiro = efectoSuperar obstaculo tiro
	| otherwise = tiroDetenido


{-
Un túnel con rampita sólo es superado si la precisión es mayor a 90 yendo al ras del suelo, 
independientemente de la velocidad del tiro. Al salir del túnel la velocidad del tiro se duplica,
la precisión pasa a ser 100 y la altura 0.
-}
tiroDetenido = UnTiro 0 0 0

superaTunel :: Tiro -> Bool
superaTunel tiro = precision tiro > 90 

efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita tiro = tiro {
	velocidad = velocidad tiro * 2,
	precision = 100,
	altura = 0
}


{-
Una laguna es superada si la velocidad del tiro es mayor a 80 y tiene una altura de entre 1 y 5 metros.
Luego de superar una laguna el tiro llega con la misma velocidad y precisión, 
pero una altura equivalente a la altura original dividida por el largo de la laguna.
-}

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && between 1 5 (altura tiro)

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largo tiro = tiro {
	altura = altura tiro `div` largo
}

{-
Un hoyo se supera si la velocidad del tiro está entre 5 y 20 m/s yendo al ras del suelo 
con una precisión mayor a 95. Al superar el hoyo, el tiro se detiene, 
quedando con todos sus componentes en 0.
-}

hoyo :: Obstaculo
hoyo = Obstaculo superaHoyo efectoHoyo

superaHoyo tiro = (between 5 20 . velocidad) tiro && precision tiro > 90
efectoHoyo _ = tiroDetenido


-- Generalizando
--

tunel :: Obstaculo
tunel = Obstaculo superaTunel efectoTunelConRampita

laguna :: Int -> Obstaculo
laguna n = Obstaculo superaLaguna (efectoLaguna n)

{-
Definir palosUtiles que dada una persona y un obstáculo, permita determinar 
qué palos le sirven para superarlo.
-}

esUtil :: Jugador -> Obstaculo -> Palo -> Bool
esUtil jugador obstaculo = puedeSuperar obstaculo . golpe jugador 

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (esUtil jugador obstaculo) palos


{-
Saber, a partir de un conjunto de obstáculos y un tiro, cuántos obstáculos consecutivos se pueden superar.

Por ejemplo, para un tiro de velocidad = 10, precisión = 95 y altura = 0, y una lista con dos túneles con
rampita seguidos de un hoyo, el resultado sería 2 ya que la velocidad al salir del segundo túnel es de 40,
por ende no supera el hoyo.

BONUS: resolver este problema sin recursividad, teniendo en cuenta que existe una función
takeWhile :: (a -> Bool) -> [a] -> [a] que podría ser de utilidad.
 

condicion :: Tiro -> Obstaculo -> Bool
condicion tiro = flip puedeSuperar tiro

obstaculosConsecutivos :: Tiro -> [Obstaculo] -> Int
obstaculosConsecutivos tiro = length . takeWhile (condicion tiro) 
-} 

consecutivos :: Tiro -> [Obstaculo] -> Int
consecutivos _ [] = length []
consecutivos tiro (x:xs)
	| puedeSuperar x tiro = 1 + consecutivos (efectoSuperar x tiro) xs
	| otherwise = 0


{-
Definir paloMasUtil que recibe una persona y una lista de obstáculos y determina cuál es el palo
que le permite superar más obstáculos con un solo tiro.
 -}

palosMasUtil :: Jugador -> [Obstaculo] -> Palo
palosMasUtil jugador obstaculos =  maximoSegun (flip consecutivos obstaculos. golpe jugador) palos
