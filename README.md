# Diversos Sistemas Expertos.

Para ejecutar-los es necesario haber descargado los programas `CLIPS-AI`,
estos se encuentran en la carpeta `clipsOK/`.

## 4 Rayas.
Se desarrolló un juego de 4 rayas con el lenguaje `CLIPS-AI` que permite
diseñar un sistema experto. En concreto, la idea es utilizar mis conocimientos
del juego 4-rayas para poder ganar a los jugadores.

Los conocimientos que posee están desde heurísticas básicas como el
caso trivial dónde el enemigo posee 3-rayas y es necesario bloquear (excepto
en que estemos en el mismo caso y entonces el movimiento ganar tiene
prioridad al bloquear) hasta heurísticas como maximizar el número de
conexiones diagonales.

## Experto Modular
Este es una representación abstracta de lo que sería discutir conmigo
sobre aspectos relacionados con la universidad con índole de decidir
que carrera o especialidad elegir dentre las posibilidades que provee
la universidad de Granada siguiendo mis criterios y ponderaciones.


## Incertidumbre
Diversos "mini" expertos modulares que hacen uso de conocimiento o lógica
difusa/probabilística para tratar con casos donde la incertidumbre está
presente y es inevitable, donde la lógica tradicional falla.

Dentro tenemos caso con probabilidad Bayesiana, Lógica difusa, Factores de
certeza, Probabilística e incluso herencia/por defecto.

Cada uno de los programas son independientes.
1. `Bayes.clp`: Determina la probabilidad de contraer Covid según las respuestas
introducidas a preguntas predeterminadas.
2. `DP.clp`: Versión probabilística de `EXPERTO MODULAR` introducido anteriormente.
3. `Difuso.clp`: Determina la dosis a tomar, de una medicina, para el usuario
que posee la enfermedad según respuestas a preguntas predeterminadas.
4. `fCerteza.clp`: Determina el problema del coche del usuario según respuestas
a preguntas predeterminadas.
5. `pDef.clp`: Razonamiento por defecto sobre aves.

## SBCFinal.
Experto modular para resolver el mismo problema que `Experto Modular` pero
con el tratado de incertidumbre y utilizando todo los conocimientos
adquiridos en la asignatura, mezclando además conocimiento de otros
compañeros y sus sistemas expertos por medio de un esquema de turno de preguntas.

