import TestMusica
import Text.Show.Functions

disminuirTiempoLibre :: Int -> Persona -> Persona
disminuirTiempoLibre min persona = persona {
	tiempoLibre = tiempoLibre persona - min
}

actualizarEstado :: (Int -> Int) -> Persona -> Persona
actualizarEstado f persona = persona {
	estadoDeAnimo = f (estadoDeAnimo persona)
}

escucharCancion :: Cancion -> Persona -> Persona
escucharCancion cancion = disminuirTiempoLibre (duracion cancion)  
