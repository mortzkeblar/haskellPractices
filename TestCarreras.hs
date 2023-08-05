module TestCarreras where

data Auto = Auto {
	color :: String,
	velocidad :: Int,
	distancia :: Int
} deriving (Eq, Show)

type Carrera = [Auto]

rayo = Auto "rojo" 80 90
mate = Auto "oxido" 30 20
doc = Auto "azul" 75 83
luigi = Auto "amarillo" 50 66
mack = Auto "rojo trailer" 40 60
sheriff = Auto "negro" 60 70
franchesco = Auto "rojo verde" 75 85
tom = Auto "patito" 90 110
{-
rayo = Auto "rojo" 0 0
mate = Auto "oxido" 0 0
doc = Auto "azul" 0 0
luigi = Auto "amarillo" 0 0
mack = Auto "rojo trailer" 0 0
sheriff = Auto "negro" 0 0
franchesco = Auto "rojo verde" 0 0
-}
carreraAutos :: Carrera
carreraAutos = [rayo, mate, doc, luigi, mack, sheriff, franchesco, tom]
