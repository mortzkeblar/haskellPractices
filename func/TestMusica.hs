module TestMusica where

data Persona = Persona {
	tiempoLibre :: Int, 
	estadoDeAnimo :: Int,
	fanDe :: [Artista]
} deriving (Eq, Show)

data Categoria = Categoria { 
	animo :: Int,
	intensidad :: Int 
}

data Cancion = Cancion {
	duracion :: Int,
	categoria :: Categoria
}

type Artista = String

type Playlist = [Cancion]


musicaClasica x = Categoria x 0

vokaliz = Cancion 4 (musicaClasica 3)
pepe = Persona 20 10 ["shakira", "karol G"]
