data Arma = Arma {
	balas :: Int,
	tamanoCargador :: Int
} deriving (Eq, Show)

data Rambo = Rambo {
	armaPrincipal :: Arma,
	armaSecundaria :: Arma
} deriving (Eq, Show)


balasTotales :: Rambo -> Int
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)

disparar :: Arma -> Arma
disparar arma | balas arma == tamanoCargador arma = arma {balas = balas arma - 2}
	      | balas arma > 0 			  = arma {balas = balas arma - 1}
	      | otherwise 			  = arma

dispararTodo :: Rambo -> Rambo
dispararTodo rambo = rambo {
		             armaPrincipal = disparar (armaPrincipal rambo),
			     armaSecundaria = disparar (armaSecundaria rambo)
			}
