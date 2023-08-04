import TestCarreras
import Text.Show.Functions

modulo :: Int -> Int -> Int
modulo x y
        | x - y > 0 = x - y 
        | otherwise = - (x - y)

colorDistinto :: Auto -> Auto -> Bool
colorDistinto auto = (/= color auto) . color

distanciaMenorA10 :: Auto -> Auto -> Bool
distanciaMenorA10 auto = (> 10) . modulo (distancia auto) . distancia

dosAutosCerca :: Auto -> Auto -> Bool
dosAutosCerca auto1 auto2 = colorDistinto auto1 auto2 && distanciaMenorA10 auto1 auto2 

primerLugar :: Auto -> Carrera -> Auto
primerLugar auto carrera = foldl max (distancia auto) (map distancia (autos carrera))

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera =all (not . dosAutosCerca auto) (autos carrera)

--puesto :: Auto -> Carrera -> Int
--puesto auto = 
