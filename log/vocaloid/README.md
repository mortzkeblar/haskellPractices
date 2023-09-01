# Vocaloid

_Es un software de síntesis de voz en el que se animan a personajes, llamados vocaloids. Muy pronto habrán varios conciertos de esta temática a lo largo de varias ciudades del mundo, y para determinar información crítica de los cantantes nos pidieron una solución en Prolog para ayudar a los organizadores a elegir los vocaloids que participarán en cada concierto._

De cada vocaloid (o cantante) se conoce el nombre y además la canción que sabe cantar. De cada canción se conoce el nombre y la cantidad de minutos de duración.

Queremos reflejar entonces que:
- megurineLuka sabe cantar la canción nightFever cuya duración es de 4 min y también canta la canción foreverYoung que dura 5 minutos.	
- hatsuneMiku sabe cantar la canción tellYourWorld que dura 4 minutos.
- gumi sabe cantar foreverYoung que dura 4 min y tellYourWorld que dura 5 min
- seeU sabe cantar novemberRain con una duración de 6 min y nightFever con una duración de 5 min.
- kaito no sabe cantar ninguna canción.

Tener en cuenta que puede haber canciones con el mismo nombre pero con diferentes duraciones.

    a) Generar la base de conocimientos inicial

Definir los siguientes predicados que sean totalmente inversibles, a menos que se indique lo contrario.

1. Para comenzar el concierto, es preferible introducir primero a los cantantes más novedosos, por lo que necesitamos un predicado para saber si un vocaloid es novedoso cuando saben al menos 2 canciones y el tiempo total que duran todas las canciones debería ser menor a 15.
	
2. Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no les gusta, es por eso que se pide saber si un cantante es acelerado, condición que se da cuando todas sus canciones duran 4 minutos o menos. Resolver sin usar forall/2.

Además de los vocaloids, conocemos información acerca de varios conciertos que se darán en un futuro no muy lejano. De cada concierto se sabe su nombre, el país donde se realizará, una cantidad de fama y el tipo de concierto.

Hay tres tipos de conciertos:
- **gigante** del cual se sabe la cantidad mínima de canciones que el cantante tiene que saber y además la duración total de todas las canciones tiene que ser mayor a una cantidad dada.
- **mediano** sólo pide que la duración total de las canciones del cantante sea menor a una 	cantidad determinada.
- **pequeño** el único requisito es que alguna de las canciones dure más de una cantidad dada.




Queremos reflejar los siguientes conciertos:

- Miku Expo, es un concierto gigante que se va a realizar en Estados Unidos, le brinda 2000 de fama al vocaloid que pueda participar en él y pide que el vocaloid sepa más de 2 canciones y el tiempo mínimo de 6 minutos.	
- Magical Mirai, se realizará en Japón y también es gigante, pero da una fama de 3000 y pide saber más de 3 canciones por cantante con un tiempo total mínimo de 10 minutos. 
- Vocalekt Visions, se realizará en Estados Unidos y es mediano brinda 1000 de fama y exige un tiempo máximo total de 9 minutos.	
- Miku Fest, se hará en Argentina y es un concierto pequeño que solo da 100 de fama al vocaloid que participe en él, con la condición de que sepa una o más canciones de más de 4 minutos.

1. Modelar los conciertos y agregar en la base de conocimiento todo lo necesario.

2. Se requiere saber si un vocaloid puede participar en un concierto, esto se da cuando cumple los requisitos del tipo de concierto. También sabemos que Hatsune Miku puede participar en cualquier concierto.

3. Conocer el vocaloid más famoso, es decir con mayor nivel de fama. El nivel de fama de un vocaloid se calcula como la fama total que le dan los conciertos en los cuales puede participar multiplicado por la cantidad de canciones que sabe cantar.

4. Sabemos que:
- megurineLuka conoce a hatsuneMiku  y a gumi 
- gumi conoce a seeU
- seeU conoce a kaito
Queremos verificar si un vocaloid es el único que participa de un concierto, esto se cumple si ninguno de sus conocidos ya sea directo o indirectos (en cualquiera de los niveles) participa en el mismo concierto.

5. Supongamos que aparece un nuevo tipo de concierto y necesitamos tenerlo en cuenta en nuestra solución, explique los cambios que habría que realizar para que siga todo funcionando. ¿Qué conceptos facilitaron dicha implementación?

