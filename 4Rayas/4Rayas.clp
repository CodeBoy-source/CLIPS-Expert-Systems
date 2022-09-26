;;;;;;; JUGADOR DE 4 en RAYA ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Version de 4 en raya clásico: Tablero de 6x7, donde se introducen fichas por arriba
;;;;;;;;;;;;;;;;;;;;;;; y caen hasta la posicion libre mas abajo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Hechos para representar un estado del juego

;;;;;;; (Turno M|J)   representa a quien corresponde el turno (M maquina, J jugador)
;;;;;;; (Tablero Juego ?i ?j _|M|J) representa que la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)

;;;;;;;;;;;;;;;; Hechos para representar estado del analisis
;;;;;;; (Tablero Analisis Posicion ?i ?j _|M|J) representa que en el analisis actual la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)
;;;;;;; (Sondeando ?n ?i ?c M|J)  ; representa que estamos analizando suponiendo que la ?n jugada h sido ?i ?c M|J
;;;

;;;;;;;;;;;;; Hechos para representar una jugadas

;;;;;;; (Juega M|J ?columna) representa que la jugada consiste en introducir la ficha en la columna ?columna

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; INICIALIZAR ESTADO


(deffacts Estado_inicial
(Tablero Juego 1 1 _) (Tablero Juego 1 2 _) (Tablero Juego 1 3 _) (Tablero Juego  1 4 _) (Tablero Juego  1 5 _) (Tablero Juego  1 6 _) (Tablero Juego  1 7 _)
(Tablero Juego 2 1 _) (Tablero Juego 2 2 _) (Tablero Juego 2 3 _) (Tablero Juego 2 4 _) (Tablero Juego 2 5 _) (Tablero Juego 2 6 _) (Tablero Juego 2 7 _)
(Tablero Juego 3 1 _) (Tablero Juego 3 2 _) (Tablero Juego 3 3 _) (Tablero Juego 3 4 _) (Tablero Juego 3 5 _) (Tablero Juego 3 6 _) (Tablero Juego 3 7 _)
(Tablero Juego 4 1 _) (Tablero Juego 4 2 _) (Tablero Juego 4 3 _) (Tablero Juego 4 4 _) (Tablero Juego 4 5 _) (Tablero Juego 4 6 _) (Tablero Juego 4 7 _)
(Tablero Juego 5 1 _) (Tablero Juego 5 2 _) (Tablero Juego 5 3 _) (Tablero Juego 5 4 _) (Tablero Juego 5 5 _) (Tablero Juego 5 6 _) (Tablero Juego 5 7 _)
(Tablero Juego 6 1 _) (Tablero Juego 6 2 _) (Tablero Juego 6 3 _) (Tablero Juego 6 4 _) (Tablero Juego 6 5 _) (Tablero Juego 6 6 _) (Tablero Juego 6 7 _)
(Jugada 0)
)

(defrule Elige_quien_comienza
=>
(printout t "Quien quieres que empieze: (escribre M para la maquina o J para empezar tu) ")
(assert (Turno (read)))
)

;;;;;;;;;;;;;;;;;;;;;;; MUESTRA POSICION ;;;;;;;;;;;;;;;;;;;;;;;
(defrule muestra_posicion
(declare (salience 10))
(muestra_posicion)
(Tablero Juego 1 1 ?p11) (Tablero Juego 1 2 ?p12) (Tablero Juego 1 3 ?p13) (Tablero Juego 1 4 ?p14) (Tablero Juego 1 5 ?p15) (Tablero Juego 1 6 ?p16) (Tablero Juego 1 7 ?p17)
(Tablero Juego 2 1 ?p21) (Tablero Juego 2 2 ?p22) (Tablero Juego 2 3 ?p23) (Tablero Juego 2 4 ?p24) (Tablero Juego 2 5 ?p25) (Tablero Juego 2 6 ?p26) (Tablero Juego 2 7 ?p27)
(Tablero Juego 3 1 ?p31) (Tablero Juego 3 2 ?p32) (Tablero Juego 3 3 ?p33) (Tablero Juego 3 4 ?p34) (Tablero Juego 3 5 ?p35) (Tablero Juego 3 6 ?p36) (Tablero Juego 3 7 ?p37)
(Tablero Juego 4 1 ?p41) (Tablero Juego 4 2 ?p42) (Tablero Juego 4 3 ?p43) (Tablero Juego 4 4 ?p44) (Tablero Juego 4 5 ?p45) (Tablero Juego 4 6 ?p46) (Tablero Juego 4 7 ?p47)
(Tablero Juego 5 1 ?p51) (Tablero Juego 5 2 ?p52) (Tablero Juego 5 3 ?p53) (Tablero Juego 5 4 ?p54) (Tablero Juego 5 5 ?p55) (Tablero Juego 5 6 ?p56) (Tablero Juego 5 7 ?p57)
(Tablero Juego 6 1 ?p61) (Tablero Juego 6 2 ?p62) (Tablero Juego 6 3 ?p63) (Tablero Juego 6 4 ?p64) (Tablero Juego 6 5 ?p65) (Tablero Juego 6 6 ?p66) (Tablero Juego 6 7 ?p67)
=>
(printout t crlf)
(printout t ?p11 " " ?p12 " " ?p13 " " ?p14 " " ?p15 " " ?p16 " " ?p17 crlf)
(printout t ?p21 " " ?p22 " " ?p23 " " ?p24 " " ?p25 " " ?p26 " " ?p27 crlf)
(printout t ?p31 " " ?p32 " " ?p33 " " ?p34 " " ?p35 " " ?p36 " " ?p37 crlf)
(printout t ?p41 " " ?p42 " " ?p43 " " ?p44 " " ?p45 " " ?p46 " " ?p47 crlf)
(printout t ?p51 " " ?p52 " " ?p53 " " ?p54 " " ?p55 " " ?p56 " " ?p57 crlf)
(printout t ?p61 " " ?p62 " " ?p63 " " ?p64 " " ?p65 " " ?p66 " " ?p67 crlf)
(printout t  crlf)
)


;;;;;;;;;;;;;;;;;;;;;; RECOGER JUGADA DEL CONTRARIO ;;;;;;;;;;;;;;;;;;;;;;;
(defrule mostrar_posicion
(declare (salience 9999))
(Turno J)
=>
(assert (muestra_posicion))
)

(defrule jugada_contrario
?f <- (Turno J)
=>
(printout t "en que columna introduces la siguiente ficha? ")
(assert (Juega J (read)))
(retract ?f)
)

(defrule juega_contrario_check_entrada_correcta
(declare (salience 1))
?f <- (Juega J ?c)
(test (and (neq ?c 1) (and (neq ?c 2) (and (neq ?c 3) (and (neq ?c 4) (and (neq ?c 5) (and (neq ?c 6) (neq ?c 7))))))))
=>
(printout t "Tienes que indicar un numero de columna: 1,2,3,4,5,6 o 7" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_check_columna_libre
(declare (salience 1))
?f <- (Juega J ?c)
(Tablero Juego 1 ?c ?X)
(test (neq ?X _))
=>
(printout t "Esa columna ya esta completa, tienes que jugar en otra" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_actualiza_estado
?f <- (Juega J ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X)
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego ?i ?c J))
)

(defrule juega_contrario_actualiza_estado_columna_vacia
?f <- (Juega J ?c)
?g <- (Tablero Juego 6 ?c _)
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego 6 ?c J))
)


;;;;;;;;;;; ACTUALIZAR  ESTADO TRAS JUGADA DE CLISP ;;;;;;;;;;;;;;;;;;

(defrule juega_clisp_actualiza_estado
?f <- (Juega M ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X)
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego ?i ?c M))
)

(defrule juega_clisp_actualiza_estado_columna_vacia
?f <- (Juega M ?c)
?g <- (Tablero Juego 6 ?c _)
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego 6 ?c M))
)

;;;;;;;;;;; CLISP JUEGA SIN CRITERIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule elegir_jugada_aleatoria
(declare (salience -9998))
?f <- (Turno M)
=>
(assert (Jugar (random 1 7)))
(retract ?f)
)

(defrule comprobar_posible_jugada_aleatoria
?f <- (Jugar ?c)
(Tablero Juego 1 ?c M|J)
=>
(retract ?f)
(assert (Turno M))
)

(defrule clisp_juega_sin_criterio
(declare (salience -9999))
?f<- (Jugar ?c)
=>
(printout t "JUEGO en la columna (sin criterio) " ?c crlf)
(retract ?f)
(assert (Juega M ?c))
(printout t "Juego sin razonar, que mal"  crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;  Comprobar si hay 4 en linea ;;;;;;;;;;;;;;;;;;;;;

(defrule cuatro_en_linea_horizontal
(declare (salience 9999))
(Tablero ?t ?i ?c1 ?jugador)
(Tablero ?t ?i ?c2 ?jugador)
(test (= (+ ?c1 1) ?c2))
(Tablero ?t ?i ?c3 ?jugador)
(test (= (+ ?c1 2) ?c3))
(Tablero ?t ?i ?c4 ?jugador)
(test (= (+ ?c1 3) ?c4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador horizontal ?i ?c1))
)

(defrule cuatro_en_linea_vertical
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i1 ?c ?jugador)
(Tablero ?t ?i2 ?c ?jugador)
(test (= (+ ?i1 1) ?i2))
(Tablero ?t ?i3 ?c  ?jugador)
(test (= (+ ?i1 2) ?i3))
(Tablero ?t ?i4 ?c  ?jugador)
(test (= (+ ?i1 3) ?i4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador vertical ?i1 ?c))
)

(defrule cuatro_en_linea_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (+ ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (+ ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (+ ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_directa ?i ?c))
)

(defrule cuatro_en_linea_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (- ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (- ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (- ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_inversa ?i ?c))
)

;;;;;;;;;;;;;;;;;;;; DESCUBRE GANADOR
(defrule gana_fila
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador horizontal ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la fila " ?i crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_columna
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador vertical ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la columna " ?c crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_directa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal que empieza la posicion " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_inversa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal hacia arriba que empieza la posicin " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
)


;;;;;;;;;;;;;;;;;;;;;;;  DETECTAR EMPATE

(defrule empate
(declare (salience -9999))
(Turno ?X)
(Tablero Juego 1 1 M|J)
(Tablero Juego 1 2 M|J)
(Tablero Juego 1 3 M|J)
(Tablero Juego 1 4 M|J)
(Tablero Juego 1 5 M|J)
(Tablero Juego 1 6 M|J)
(Tablero Juego 1 7 M|J)
=>
(printout t "EMPATE! Se ha llegado al final del juego sin que nadie gane" crlf)
)

;;;;;;;;;;;;;;;;;;;;;; CONOCIMIENTO EXPERTO ;;;;;;;;;;
;;;;; ¡¡¡¡¡¡¡¡¡¡ Añadir conocimiento para que juege como vosotros jugariais !!!!!!!!!!!!

;; Verificamos la posición siguiente en horizontal a la entrada i j
(defrule siguiente_horizontal
 (declare (salience 9999))
 (Tablero Juego ?i ?j ?X)
 (Tablero Juego ?i1 ?j1 ?Y)
 (test (= ?i ?i1 ) )
 (test (= (+ ?j 1) ?j1) )
=>
 (assert (siguiente ?i ?j h ?i1 ?j1) )
 (assert (anterior ?i1 ?j1 h ?i ?j) )
)

;; Verificamos la posición siguiente en vertical a la entrada i j
(defrule siguiente_vertical
 (declare (salience 9999))
 (Tablero Juego ?i ?j ?X)
 (Tablero Juego ?i1 ?j1 ?Y)
 (test (= ?j ?j1 ) )
 (test (= (- ?i 1) ?i1) )
=>
 (assert (siguiente ?i ?j v ?i1 ?j1) )
 (assert (anterior ?i1 ?j1 v ?i ?j) )
)

;; Verificamos la posición siguiente en diagonal derecha a la entrada i j
(defrule siguiente_diagonalR
 (declare (salience 9999))
 (Tablero Juego ?i ?j ?X)
 (Tablero Juego ?i1 ?j1 ?Y)
 (test (= (+ ?j 1) ?j1) )
 (test (= (- ?i 1) ?i1) )
=>
 (assert (siguiente ?i ?j dr ?i1 ?j1) )
 (assert (anterior ?i1 ?j1 dr ?i ?j) )
)

;; Verificamos la posición siguiente en diagonal izquierda a la entrada i j
(defrule siguiente_diagonalL
 (declare (salience 9999))
 (Tablero Juego ?i ?j ?X)
 (Tablero Juego ?i1 ?j1 ?Y)
 (test (= (- ?j 1) ?j1) )
 (test (= (- ?i 1) ?i1) )
=>
 (assert (siguiente ?i ?j dl ?i1 ?j1) )
 (assert (anterior ?i1 ?j1 dl ?i ?j) )
)

;; Actualizamos la base de hechos asumiendo que todas fichas caeran en la última fila
(defrule caida_inicial
    (declare (salience 9001))
    (Tablero Juego 6 ?j _)
    =>
    (assert (caeria 6 ?j))
)

;; Con cada jugada actualizamos donde caería la ficha jugada en la columna j
(defrule caida
 (declare (salience 9000))
 (Tablero Juego ?i ?j _)
 (anterior ?i ?j v ?i1 ?j1)
 (Tablero Juego ?i1 ?j1 M|J)
 ?c <- (caeria ?i1 ?j1)
 =>
 (retract ?c)
 (assert (caeria ?i ?j))
)

(defrule limpia_caeria
    (declare (salience 8999))
    ?c <- (caeria 1 ?j)
    (not (Tablero Juego 1 ?j _) )
    =>
    (retract ?c)
)

;; Verificamos que hay dos posiciones adjuntas pertenecientes al mismo jugador.
(defrule conexion_a_dos
    (declare (salience 9000))
    (Tablero Juego ?i ?j ?J)
    (test (not (eq ?J _) ) )
    (siguiente ?i ?j ?d ?i1 ?j1)
    (Tablero Juego ?i1 ?j1 ?J)
    (test (<= ?i1 ?i ))
    =>
    (assert (conectado juego ?i ?j ?d ?i1 ?j1 ?J) )
)

;; Verificamos con el uso de la función anterior si se presenta una situación de tres en raya
(defrule conexion_a_tres
    (declare (salience 8000))
    (conectado juego ?i ?j ?d ?i1 ?j1 ?J)
    (conectado juego ?i1 ?j1 ?d ?i2 ?j2 ?J)
    =>
    (assert (3_en_linea juego ?i ?j ?d ?i2 ?j2 ?J))
)

;; Caso patologico de 3 en raya con espacio en blanco de por medio
(defrule conexion_a_tres_derecha
 (declare (salience 8000))
 (conectado juego ?i ?j ?d ?i1 ?j1 ?J)
 (siguiente ?i1 ?j1 ?d ?i2 ?j2)
 (Tablero Juego ?i2 ?j2 _)
 (siguiente ?i2 ?j2 ?d ?i3 ?j3)
 (Tablero Juego ?i3 ?j3 ?J)
=>
(assert (ganaria ?J ?i2 ?j2) )
 )

(defrule conexion_a_tres_izquierda
 (declare (salience 8000))
 (conectado juego ?i ?j ?d ?i1 ?j1 ?J)
 (anterior ?i ?j ?d ?i2 ?j2)
 (Tablero Juego ?i2 ?j2 _ )
 (anterior ?i2 ?j2 ?d ?i3 ?j3)
 (Tablero Juego ?i3 ?j3 ?J)
=>
 (assert (ganaria ?J ?i2 ?j2) )
 )

;; Con el uso de la función anterior, verificamos en que dirección ganará el jugador.
(defrule ganara_horizontal_derecha
    (declare (salience 7000))
    (3_en_linea juego ?i ?j h ?i1 ?j1 ?J)
    (siguiente ?i1 ?j1 h ?i2 ?j2)
    (Tablero Juego ?i2 ?j2 _)
    =>
    (assert (ganaria ?J ?i2 ?j2) )
)

;; Verificamos si ganaria en la direccion contraria
(defrule ganara_horizontal_izquierda
    (declare (salience 7000))
    (3_en_linea juego ?i ?j h ?i1 ?j1 ?J)
    (anterior ?i ?j h ?i2 ?j2)
    (Tablero Juego ?i2 ?j2 _)
    =>
    (assert (ganaria ?J ?i2 ?j2) )
)

;; Verificamos si ganaria en la direccion contraria
(defrule ganara_diagonal_reverse
    (declare (salience 7000))
    (3_en_linea juego ?i ?j dr|dl ?i1 ?j1 ?J)
    (anterior ?i ?j dr|dl ?i2 ?j2)
    (Tablero Juego ?i2 ?j2 _)
    =>
    (assert (ganaria ?J ?i2 ?j2) )
)

;; Caso de ganar alguna otra dirección
(defrule ganara
    (declare (salience 7000))
    (3_en_linea juego ?i ?j ?d ?i1 ?j1 ?J)
    (siguiente ?i1 ?j1 ?d ?i2 ?j2)
    (Tablero Juego ?i2 ?j2 _)
    =>
    (assert (ganaria ?J ?i2 ?j2) )
)

;; Si alguien gana y además cae justo en esa posición, activamos el hecho de
;; que alguien gana.
(defrule activar_alguien_gana
    (declare (salience 6999))
    (ganaria ?J ?i ?j)
    (caeria ?i ?j)
    =>
    (assert (alguien-gana))
)

; Quitar aquellos ganaria que se bloquearon
(defrule verificar_ganaria
    (declare (salience 9000 ) )
    ?f <- (alguien-gana)
    ?g <- (ganaria ?J ?i ?j)
    (not (Tablero Juego ?i ?j _ ) )
    =>
    (retract ?f ?g)
)

;; Función básica para ganar en caso de que pudiera
(defrule ganar
    (declare (salience -999))
    ?f <- (Turno M)
    ?g <- (ganaria M ?i ?j)
    (caeria ?i ?j)
    ?h <- (alguien-gana)
    =>
    (retract ?f ?g ?h)
    (assert (Juega M ?j))
    (printout t "Se te ha escapado esta posibilidad, ¡Bien jugado!" crlf)
)

;; Función clara de bloquear una posible victoria del jugador;
(defrule bloquear
    (declare (salience -1000))
    ?f <- (Turno M)
    ?g <- (ganaria J ?i ?j)
    (caeria ?i ?j)
    ?h <- (alguien-gana)
    =>
    (retract ?f ?g ?h)
    (assert (Juega M ?j))
    (printout t "¡He visto bien tu jugada! Para evitar perder tan pronto he tenido que bloquearte en: " ?i " " ?j crlf)
)

;; Evitamos que nos pueda ganar creando posibilidades en dos direcciones
(defrule evitar_doble_ganar
    (declare (salience -3001))
    (Turno M)
    (not (alguien-gana ) )
    (conectado juego ?i ?j h ?i ?j2 J)
    (siguiente ?i ?j2 h ?i ?j3)
    (Tablero Juego ?i ?j3 _)
    (anterior ?i ?j h ?i ?j4)
    (Tablero Juego ?i ?j4 _)
    =>
    (assert (bloquear amplio ?i ?j ?i ?j2 ) )
)

;; Verificamos esa condicion para el lado derecho
(defrule bloquear_doble_derecha
    (declare (salience -3000))
    ?f <- (Turno M)
    (not (alguien-gana ) )
    ?b <- (bloquear amplio ?i ?j ?i ?j2)
    (siguiente ?i ?j2 h ?i ?j3)
    (siguiente ?i ?j3 h ?i ?j4)
    (Tablero Juego ?i ?j3 _)
    (Tablero Juego ?i ?j4 _)
    (caeria ?i ?j3)
    (caeria ?i ?j4)
    =>
    (retract ?f ?b )
    (assert (Juega M ?j3) )
    (printout t "Juego en esta columna para evitar que me puedas ganar forzandome
a tener que bloquear por dos lados en horizontal." crlf)
)

;; Verificamos esa condicion para el lado izquierdo
(defrule bloquear_doble_izquierda
    (declare (salience -3000))
    ?f <- (Turno M)
    (not (alguien-gana ) )
    ?b <- (bloquear amplio ?i ?j ?i ?j2)
    (anterior ?i ?j h ?i ?j3)
    (anterior ?i ?j3 h ?i ?j4)
    (Tablero Juego ?i ?j3 _)
    (Tablero Juego ?i ?j4 _)
    (caeria ?i ?j3)
    (caeria ?i ?j4)
    =>
    (retract ?f ?b )
    (assert (Juega M ?j3) )
    (printout t "Juego en esta columna para evitar que me puedas ganar forzandome
a tener que bloquear por dos lados en horizontal." crlf)
)

;; Mi método de juga consisten prioritariamente en crear torres verticales
(defrule prioridad_vertical_tres
    (declare (salience -4000))
    ?f <- (Turno M)
    (not (alguien-gana) )
    (conectado juego ?i ?j v ?i1 ?j1 M)
    (siguiente ?i1 ?j1 v ?i2 ?j2 )
    (caeria ?i2 ?j2)
    (test (>= ?i2 2) )
    (not (perderia_en_dos ?i2 ?j2))
    =>
    (retract ?f )
    (assert (Juega M ?j2))
    (printout t "Juego aquí porque le suelo dar prioridad al mundo vertical ya que
es un armario lleno de oportunidades de conexiones para el futuro, haciendo que tengas
que tener en consideración muchas más variables en juego." crlf)
)

;; Verificamos si podriamos ocasionar una jugada en la que perdiaramos a continuación
(defrule mira_alrededores_horizontal
    (declare (salience 9999) )
    (Tablero Juego ?i ?j _)
    (not (perderia_en_dos ?i ?j) )
    (and (or (anterior ?i ?j h ?i2 ?j2) (siguiente ?i ?j h ?i2 ?j2) ) (ganaria J ?i2 ?j2) )
    =>
    (assert (perderia_en_dos ?i ?j))
)

(defrule mira_alrededores_vertical
    (declare (salience 9999) )
    (Tablero Juego ?i ?j _)
    (not (perderia_en_dos ?i ?j) )
    (and (siguiente ?i ?j v ?i2 ?j2)  (ganaria J ?i2 ?j2) )
    =>
    (assert (perderia_en_dos ?i ?j))
)

(defrule mira_alrededores_diagonalD
    (declare (salience 9999) )
    (Tablero Juego ?i ?j _)
    (not (perderia_en_dos ?i ?j) )
    (and (or (anterior ?i ?j dr ?i2 ?j2) (siguiente ?i ?j dr ?i2 ?j2) ) (ganaria J ?i2 ?j2) )
    =>
    (assert (perderia_en_dos ?i ?j))
)

(defrule mira_alrededores_diagonalD
    (declare (salience 9999) )
    (Tablero Juego ?i ?j _)
    (not (perderia_en_dos ?i ?j) )
    (and (or (anterior ?i ?j dl ?i2 ?j2) (siguiente ?i ?j dl ?i2 ?j2) ) (ganaria J ?i2 ?j2) )
    =>
    (assert (perderia_en_dos ?i ?j))
)

;; Limpiamos los perderias inútiles debido a que la posición ya se ocupó
(defrule limpia_perderias
    (declare (salience 9998) )
    ?p <- (perderia_en_dos ?i ?j)
    (not (Tablero Juego ?i ?j _) )
    =>
    (retract ?p)
)

;; Queremos crear torres como he dicho anteriormente
(defrule prioridad_vertical
    (declare (salience -4001))
    ?f <- (Turno M)
    (not (alguien-gana) )
    (Tablero Juego ?i ?j M)
    (siguiente ?i ?j v ?i2 ?j2 )
    (caeria ?i2 ?j2)
    (test (>= ?i2 3) )
    (not (perderia_en_dos ?i2 ?j2))
    =>
    (retract ?f )
    (assert (Juega M ?j2))
    (printout t "Juego aquí porque le suelo dar prioridad al mundo vertical ya que
es un armario lleno de oportunidades de conexiones para el futuro, haciendo que tengas
que tener en consideración muchas más variables en juego." crlf)
)

;; Algunas ideas de juego
(defrule prioridad_vertical_inicial
    (declare (salience -4002))
    ?f <- (Turno M)
    (not (alguien-gana ) )
    (Tablero Juego ?i ?j ?X)
    (siguiente ?i ?j v ?i1 ?j1)
    (Tablero Juego ?i1 ?j1 _)
    (caeria ?i1 ?j1)
    (test (>= ?i1 4) )
    (not (perderia_en_dos ?i1 ?j1))
    =>
    (retract ?f)
    (assert (Juega M ?j))
    (printout t "Mi idea principal para este juego es de ir formando torres,
para incrementar el número de variables que el enemigo tiene que tener en cuenta y \
facilitando posibles conexiones futuras mías." crlf)
)

;; El centro nos permite tener una gran ventaja sobre el jugador.
(defrule prioridad_centro_inicial
    (declare (salience -9000))
    ?f <- (Turno M)
    (Tablero Juego 6 4 _)
    =>
    (retract ?f )
    (assert (Juega M 4))
    (printout t "En el inicio del juego, siempre es oportuno intentar acudir al centro
ya que este te permite relacionar el mayor número de fichas en el tablero." crlf)
)

;; A mitad del juego hay que cambiar un poco la jugada.
(defrule prioridad_vertical_midgame
    (declare (salience -9990))
    ?f <- (Turno M)
    (not (alguien-gana) )
    (Tablero Juego ?i ?j ?J)
    (siguiente ?i ?j v ?i2 ?j2 )
    (caeria ?i2 ?j2)
    (not (perderia_en_dos ?i2 ?j2))
    (test (>= ?i2 3) )
    =>
    (retract ?f )
    (assert (Juega M ?j2))
    (printout t "Ya hay que ir teniendo mayor cuidado con los movimientos, hemos llegado a la parte \
importante del juego. Estoy plantendo conexiones; Recuerda siempre bloquear y/o conectar con tus piezas" crlf)
)

;; Buscar la mayor flexibilidad al final del tablero
(defrule prioridad_vertical_final_espacios
    (declare (salience -9991))
    ?f <- (Turno M)
    (not (alguien-gana) )
    (Tablero Juego ?i ?j _)
    (caeria ?i ?j)
    (not (perderia_en_dos ?i ?j))
    (or (test (>= ?i 3) )
        (and (or (siguiente ?i ?j h ?i1 ?j1) (anterior ?i ?j h ?i1 ?j1) ) (caeria ?i1 ?j1) )
        (and (siguiente ?i ?j dr|dl ?i1 ?j1)  (caeria ?i1 ?j1) )
    )
    =>
    (retract ?f )
    (assert (Juega M ?j))
    (printout t "En casos extremos como estos, dónde ya no puede seguir con mi criterio
de verticalidad, suelo optar entonces por los caminos más flexibles. Estos en última instancia \
son aquellas columnas que poseen algún número de posiblidad." crlf)
)
