module Golf where

-- Modelo inicial

data Jugador = UnJugador {
	nombre :: String,
	padre  :: String, 
	habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
	fuerzaJugador :: Int,
	precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo

bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
	velocidad :: Int, 
	precision :: Int,
	altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones Utiles

between n m x = elem x [n .. m]

mayorSegun :: Ord x => (t -> x) -> (t -> t -> t)
mayorSegun f a b
	| f a > f b = a
	| otherwise = b

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun f = foldl1 (mayorSegun f)

