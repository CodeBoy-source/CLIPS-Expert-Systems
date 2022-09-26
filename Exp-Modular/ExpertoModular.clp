(defrule init
    =>
    (focus A)
)

;;;; Copyright Brian Sena Simons
;; El modulo A posee el conocimiento compartido
(defmodule A (export deftemplate Respuestas )
             (export deftemplate next-turn  )
             (export deftemplate decisiones )
             (export deftemplate razones    )
             (export deftemplate estados    ))

;; Conocmiento compartido
(deftemplate Respuestas
    (field software) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field matematicas) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field programar) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field teoria) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field base_de_datos) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field nota) ;;  ALTA, MEDIA, BAJA, NOLOSE
    (field trabajo) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field trabajador) ;; DESCONOCIDO, SI, NO, NOLOSE
    (field ejemplos_fisicos) ;; DESCONOCIDO, SI, NO, NOLOSE
)
;; Conocimiento de los turnos
(deftemplate next-turn
    (slot next) (slot preguntado)
)

;; Conocimiento sobre las justificaciones
(deftemplate decisiones
    (slot desc1 (type STRING))
    (slot desc2 (type STRING))
    (slot desc3 (type STRING))
)
;; Conocimiento sobre las justificaciones
(deftemplate razones
    (slot just1 (type STRING))
    (slot just2 (type STRING) )
    (slot just3 (type STRING) )
)
;; Conocimiento sobre los estados
(deftemplate estados
    (slot estadoA)
    (slot estadoB)
)

;; Función para guiar los cambios de turno
(deffunction change_turn (?x)
    (if
    (eq (fact-slot-value ?x next) true)
    then
        (modify ?x (preguntado false)) (modify ?x (next false)) (focus B)
    else
        (modify ?x (next true))
    )
)

;; Definimos los hechos/instancias iniciales
(deffacts Hechos
    (Respuestas (software UNKNOWN)
                (matematicas UNKNOWN)
                (nota UNKNOWN)
                (programar UNKNOWN)
                (teoria UNKNOWN)
                (base_de_datos UNKNOWN)
                (trabajo UNKNOWN)
                (trabajador UNKNOWN)
                (ejemplos_fisicos UNKNOWN)
    )
    (next-turn (next true) (preguntado false))
    (decisiones (desc1 "") (desc2 "") (desc3 ""))
    (razones (just1 "") (just2 "") (just3 ""))
    (estados (estadoA Procesando) (estadoB Procesando) )
)

;;;; #####################################################################
; Definimos una lista de ramas iniciales a recomendar
; Lo que haremos es ir quitando según responda a las preguntas.
; Una vez respondida las preguntas y/o solamente queda 1 objeto en la lista
; Accionamos la función que decidir_y_explicar que imprimi el resultado por pantalla
(defclass Ramas (is-a USER)
    (multislot lista
        (type STRING)
        (allowed-strings "IC" "SI" "IS" "TI" "CSI")
        (create-accessor read-write)
    )
    (multislot conclusion
        (type STRING)
        (create-accessor read-write)
    )
    (multislot justificacion
        (type STRING)
        (create-accessor read-write)
    )
)

;;;; #####################################################################
;; Esta función nos permite verificar que el usuario introduce valores
;; que corresponden a las posibles respuestas o valores-permitidos.
;; No es case-sensitive pero devuelve la respuesta en mayuscula
(deffunction pregunta (?pregunta $?valores-permitidos)
    (progn$  (?var ?valores-permitidos) (upcase ?var) )
    (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos) )
    (bind ?respuesta (read))
    (while (not (member$ (upcase ?respuesta) ?valores-permitidos)) do
        (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos))
        (bind ?respuesta (read))
    )
    (bind ?respuesta (upcase ?respuesta) )
)
;; Esta función nos permite verificar que el usuario introduce un número
;; compreendido dentro de un rango definido
(deffunction pregunta-numerica (?pregunta ?rangini ?rangfi)
    (format t "%s [%d, %d]: " ?pregunta ?rangini ?rangfi )
    (bind ?respuesta (read))
    (while (not (and (>= ?respuesta ?rangini) (<= ?respuesta ?rangfi) ) ) do
        (format t "%s [%d, %d]: " ?pregunta ?rangini ?rangfi )
        (bind ?respuesta (read))
    )
    ?respuesta
)

;; Esta es una función auxiliar que nos permite encontrar el index de un
;; string dentro de un array; Si no existe retorna nil;
(deffunction encontrar_index (?valor $?array)
    (bind ?respuesta nil)
    (bind ?i 1)
    (while (<= ?i (length$ ?array) )
    do
        (bind ?rama (nth$ ?i ?array) )
        (if (eq ?rama ?valor) then
            (bind ?respuesta ?i)
            (bind ?i (length$ ?array) )
        )
        (bind ?i (+ ?i 1) )
    )
    ?respuesta
)
;; Esta función utiliza la función auxiliar anterior para borrar un elemento
;; del array; Si este no existe no hace nada;
(deffunction borrar_valor (?user ?valor)
    (bind ?respuesta (send ?user get-lista))
    (bind ?i1 (encontrar_index ?valor ?respuesta) )
    (if (not (eq ?i1 nil) ) then
        (slot-delete$ ?user lista ?i1 ?i1  )
    )
    (bind ?respuesta (send ?user get-lista))
    ?respuesta
)
;; Esta función es una para depurar, imprimir los valores de un array.
(deffunction imprimir_ramas (?array)
    (bind ?i 1)
    ;(bind ?array (send ?user get-lista) )
    (while (<= ?i (length$ ?array) )
    do
        (bind ?rama (nth$ ?i ?array) )
        (printout t ?rama " ")
        (bind ?i (+ ?i 1) )
    )
    (printout t crlf)
)

;; Es una función para insertar la explicación en nuestra instancia
(deffunction insertar_explicacion  (?user ?valor)
    (slot-insert$ ?user justificacion 1 ?valor)
)

;; La función que se llama al finalizar la ejecución del programa
;; Imprimir todo lo contenido en nuestra instancia Ramas convertiendo las
;; siglas en los nombres correspondientes de las asignaturas
(deffunction decidir_y_explicar (?user)
    (bind ?arr (send ?user get-lista))
    (bind ?i 1)
    ;(bind ?array (send ?user get-lista) )
    (while (<= ?i (length$ ?arr) )
    do
        (bind ?rama (nth$ ?i ?arr) )
        (if (eq ?rama "IC") then (slot-insert$ ?user conclusion 1 "Ingenieria de computadores" )  )
        (if (eq ?rama "CSI") then (slot-insert$ ?user conclusion 1 "Computación y Sistemas Inteligentes" )  )
        (if (eq ?rama "IS") then (slot-insert$ ?user conclusion 1 "Ingenieria de Software" )  )
        (if (eq ?rama "SI") then (slot-insert$ ?user conclusion 1 "Sistemas de información" )  )
        (if (eq ?rama "TI") then (slot-insert$ ?user conclusion 1 "Tecnologias de la información" )  )
        (bind ?i (+ ?i 1) )
    )
    (bind ?res (send ?user get-conclusion))
    ;(printout t "Con las respuestas obtenidas, mi conclusión sería recomendarte las  \
;siguientes ramas: " crlf )
    (loop-for-count (?i 1 (length$ ?res) ) do
        ;(printout t ?i " - " (nth$ ?i ?res ) crlf )
        (do-for-fact ((?d decisiones)) TRUE
            (bind ?string (str-cat (nth$ ?i ?res) ", " ) )
            (modify ?d (desc1 (str-cat ?string ?d:desc1)))
            )
        )
        (bind ?exp (send ?user get-justificacion))
        ;(printout t "Las razones por detrás de esas decisiones son que " crlf )
    (loop-for-count (?i 1 (- (length$ ?exp) 2) ) do
        ;(printout t (nth$ ?i ?exp ) ", " )
        (do-for-fact ((?j razones)) TRUE
            (modify ?j (just1 (str-cat ?j:just1 (nth$ ?i ?exp) )))
            (modify ?j (just1 (str-cat ?j:just1 ", " )))
        )
        (if (eq (mod ?i 2) 0) then
        ;(printout t crlf)
        )
    )
    ; (printout t (nth$ (- (length$ ?exp) 1) ?exp) )
    (do-for-fact ((?j razones)) TRUE
        (modify ?j (just1 (str-cat ?j:just1 (nth$ (- (length$ ?exp) 1) ?exp) )))
    )
    ;(printout t " y por último "(nth$ (length$ ?exp) ?exp) "." crlf )
    ;(printout t "[Por Curiosidad]: " crlf)
    ;(printout t "Mis favoritas son Computación y Sistemas inteligentes e Ingenieria del Software :D" crlf)
    ;(printout t "Si tuviera que elegir del mundo del hardware sería la Ingeniería de Computadores..." crlf)
    ;(printout t "Gracias por preguntar mi opinión, espero que te gusten, ¡hasta luego!" crlf)
)

;;;; #####################################################################

;; Inicializamos los valores y creamos las instancias;
(defrule initialize_values
    (declare (salience 9999))
     =>
     (make-instance ramas of Ramas (lista "IC" "SI" "IS" "TI" "CSI") )
     (assert (software UNKNOWN))
     (assert (matematicas UNKNOWN))
     (assert (teoria UNKNOWN))
     (assert (base_de_datos UNKNOWN))
     (assert (nota UNKNOWN))
     (assert (programar UNKNOWN))
     (assert (ejemplos_fisicos UNKNOWN))
)

;; Por cada pregunta respondida retiramos la sentencia y añadimos ask_?1 DONE
;; Luego además, por cada pregunta respondida tendremos nuevos hechos que
;; ejecutarán las reglas de añadir justificación a nuestra instancia de usuario.

;; Damos la bienvenido al usuario y le introducimos al programa
(defrule initialize (declare (salience 9998))
    =>
    (printout t "##########!!!!!##############!!!!!##############"crlf)
    (printout t "Bienvenido a nuestro aconsejador" crlf)
    (printout t "Para que sea breve, utilizaré preguntas que antes dividan las \
ramas en diferentes categorias, empezemos!" crlf)
    (printout t "##########!!!!!##############!!!!!##############"crlf)
)

;; Empezamos preguntando por si prefiere software, ya que antes divide las ramas.
(defrule preguntar_software
    (declare (salience 5))
    ?r <- (Respuestas (software UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (software UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta "Si tuvieras que elegir, ¿dirías que prefieres \
Software a Hardware?" (create$ SI NO NOLOSE) ))
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (software ?respuesta) )
    else
        (printout t "Huhm...no me ayudas eh.." crlf)
        (modify ?t (next true) )
        (change_turn ?t)
        )
    (assert (ask_software DONE) )

    (modify ?t (preguntado true))
    (modify ?r (software ?respuesta))
)

(defrule software_changed
    (declare (salience -4004 ))
    ?r <- (Respuestas (software ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (software ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (software ?algo) )
    (assert (ask_software DONE) )
)

;; Y así con las siguientes reglas vamos preguntando en ese orden...
(defrule preguntar_mates
    (declare (salience 4))
    ?r <- (Respuestas (matematicas UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (matematicas UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta "Por cierto, ¿te gustan las matemáticas?" (create$ SI NO NOLOSE) ) )
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (matematicas ?respuesta) )
    else
        (printout t "¿Enserio? Bueno siguiente" crlf)
        (modify ?t (next true) )
        (change_turn ?t)
        )
    (assert (ask_matematicas DONE) )

    (modify ?t (preguntado true))
    (modify ?r (matematicas ?respuesta))
)

(defrule math_changed
    (declare (salience -4004 ))
    ?r <- (Respuestas (matematicas ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (matematicas ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (ask_matematicas DONE) )
    (assert (matematicas ?algo) )
)

(defrule preguntar_nota
    (declare (salience 3))
    ?r <- (Respuestas (nota UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (nota UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta-numerica "Por curiosidad, ¿cuál es tu nota media?" 0 10) )
    (assert (nota ?respuesta))
    (assert (ask_notas DONE) )

    (modify ?t (preguntado true))
    ; (modify ?r (matematicas ?respuesta))
)

(defrule nota_changed
    (declare (salience -4004) )
    ?r <- (Respuestas (nota ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (nota ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (nota ?algo) )
    (assert (ask_notas DONE))
)

(defrule preguntar_teoria
    (declare (salience 2))
    ?r <- (Respuestas (teoria UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (teoria UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta "Y bueno a todo esto, ¿eres más de teoría que de prácticas \
verdad?" (create$ SI NO NOLOSE) ) )
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (teoria ?respuesta) )
    else
        (printout t "Al final te tendré que decir mis favoritas y yasta..." crlf)
        (modify ?t (next true) )
        (change_turn ?t)
        )
    (assert (ask_teoria DONE) )

    (modify ?t (preguntado true))
    (modify ?r (teoria ?respuesta))
)

(defrule teoria_changed
    (declare (salience -4004) )
    ?r <- (Respuestas (teoria ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (teoria ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (teoria ?algo) )
    (assert (ask_teoria DONE) )
)

(defrule preguntar_base_datos
    (declare (salience 1))
    ?r <- (Respuestas (base_de_datos UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (base_de_datos UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta "Una de las preguntas que me ayudaría mucho que  \
respondieras es a la siguiente, \
¿te gustan las bases de datos?" (create$ SI NO NOLOSE) ) )
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (base_de_datos ?respuesta) )
    else
        (printout t "En verdad si sabes...." crlf)
        (modify ?t (next true) )
        (change_turn ?t)
        )
    (assert (ask_base_de_datos DONE) )

    (modify ?t (preguntado true))
    (modify ?r (base_de_datos ?respuesta))
)

(defrule base_datos_changed
    (declare (salience -4004) )
    ?r <- (Respuestas (base_de_datos ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (base_de_datos ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (ask_base_de_datos DONE))
    (assert (base_de_datos ?algo) )
)

(defrule preguntar_programar
    (declare (salience 0))
    ?r <- (Respuestas (programar UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (programar UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta-numerica "Se me olvidaba lo más importante, del 1 al 5, \
¿cuánto te gusta programar?" 1 5) )
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (programar ?respuesta) )
    else
        (printout t "En verdad si sabes...." crlf)
        (modify ?t (next true) )
        (change_turn ?t)
        )
    (assert (ask_programar DONE) )

    (modify ?t (preguntado true))
    (modify ?r (programar ?respuesta))
)

(defrule programar_changed
    (declare (salience -4004) )
    ?r <- (Respuestas (programar ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (programar ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (programar ?algo) )
    (assert (ask_programar DONE) )
)

(defrule preguntar_ejemplos_físicos
    (declare (salience -1))
    ?r <- (Respuestas (ejemplos_fisicos UNKNOWN))
    ?t <- (next-turn (preguntado false))

    ?f <- (ejemplos_fisicos UNKNOWN)
    (not (finished) )
    =>
    (retract ?f)
    (bind ?respuesta (pregunta-numerica "Ya con esto termino, te lo prometo, del 1 al 5, \
¿cuánto te importa los ejemplos fisicos? (robots,visuales...)" 1 5) )
    (if (not (eq ?respuesta NOLOSE ) ) then (assert (ejemplos_fisicos ?respuesta) ) )
    (assert (ask_ejemplos_fisicos DONE) )

    (modify ?t (preguntado true))
    (modify ?r (ejemplos_fisicos ?respuesta))
)

(defrule ejemplos_fisicos_changed
    (declare (salience -4004) )
    ?r <- (Respuestas (ejemplos_fisicos ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    ?f <- (ejemplos_fisicos ?otro)
    (not (test (eq ?otro ?algo) )  )
    =>
    (retract ?f)
    (assert (ejemplos_fisicos ?algo))
    (assert (ask_ejemplos_fisicos DONE) )
)

;;;; #####################################################################

;; Con las siguientes reglas lo que haremos es trabajar sobre las respuestas
;; En caso positivo/negativo tendremos que quitar alguna rama de la lista
;; En caso neutro no haremos nada al respecto
;; En algunas ocasiones es importante saber respuestas anteriores

(defrule software_positivo
    (declare (salience 99))
    ?r <- (Respuestas (software SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (software SI)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_software))
    (printout t "Sabía que eras uno de los míos! ;) " crlf)
    (borrar_valor ?user "IC")
    (borrar_valor ?user "TI")
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "te gusta el software")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "te gusta el software" ?a )))
)

(defrule software_negativo
    (declare (salience 99))

    ?r <- (Respuestas (software NO))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (software NO)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_hardware) )
    (printout t "Vaya, creía que era uno de los mios ;(" crlf)
    (borrar_valor ?user "IS")
    (borrar_valor ?user "CSI")
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "No te gusta el software")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "No te gusta el software" ?a )))
)

;;;; #####################################################################

(defrule matematicas_negativo
    (declare (salience 99))

    ?r <- (Respuestas (matematicas NO))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a) )

    ?f <- (matematicas NO)
    ?user <- (object (is-a USER) (lista $?array) )
    =>
    (retract ?f)
    (printout t "Pues a mi me gustan las matematicas, son muy útiles!" crlf)
    (borrar_valor ?user "CSI")
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "no te gustan las matematicas")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "no te gustan las matematicas" ?a )))
)

(defrule matematicas_positivo
    (declare (salience 99))
    ?r <- (Respuestas (matematicas SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (matematicas SI)
    ?user <- (object (is-a USER) (lista $?array) )
    =>
    (retract ?f)
    (assert (prefiere_matematicas) )
    (printout t "Pues a mi también me gustan las matematicas, son muy útiles!" crlf)
    (insertar_explicacion ?user "te gustan las matematicas")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "te gustan las matematicas" ?a )))
)

;;;; #####################################################################

(defrule nota-alta
    (declare (salience 99))
    ?r <- (Respuestas (nota UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (nota ?n)
    (test (not (eq ?n UNKNOWN) ) )
    (test (>= ?n 9) )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (nota_alta))
    (printout t "Wow! Que nota más alta, se nota que eres trabajador!" crlf)
    (assert (trabajador_mucho))
    (insertar_explicacion ?user "tienes la nota alta y eres trabajador")

    (modify ?r (nota ALTA) )
    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "tienes la nota alta y eres trabajador" ?a )))
)

(defrule nota-media
    (declare (salience 99))
    ?r <- (Respuestas (nota UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (nota ?n)
    (test (not (eq ?n UNKNOWN) ) )
    (test (and (>= ?n 7) (< ?n 9) ) )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (nota_media))
    (printout t "Uy que bien, veo que te esfuerzas mogollón!" crlf)
    (assert (trabajador_medio))
    (insertar_explicacion ?user "no tienes la nota tan alta pero te esfuerzas bastante")

    (modify ?r (nota MEDIA) )
    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "no tienes la nota tan alta pero te esfuerzas bastante" ?a )))
)

(defrule nota-baja
    (declare (salience 99))
    ?r <- (Respuestas (nota UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (nota ?n)
    (test (not (eq ?n UNKNOWN) ) )
    (test (<= ?n 6) )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (nota_baja))
    (printout t "Vale con eso ya me voy haciendo una idea.." crlf)
    (assert (trabajador_poco))
    (insertar_explicacion ?user "tienes la nota flojita pero te esfuerzas bastante")

    (change_turn ?t)
    (modify ?r (nota BAJA) )
     ;; (modify ?j (just1 (str-cat "tienes la nota flojita pero te esfuerzas bastante" ?a )))
)

;; Aquí por ejemplo es un primer ejemplo de funcion que recuerda una respuesta
(defrule nota-alta-software
    (declare (salience 99))
    ?r <- (Respuestas (nota alta) (software SI))
    ?t <- (next-turn (next ?z) )

    (prefiere_software)
    (nota_alta)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (borrar_valor ?user "SI")
    ;;(imprimir_ramas ?array)

    (change_turn ?t)
)
(defrule nota-alta-hardware
    (declare (salience 99))
    ?r <- (Respuestas (nota alta) (software NO))
    ?t <- (next-turn (next ?z) )

    (prefiere_hardware)
    (nota_alta)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (borrar_valor ?user "TI")
    ;;(imprimir_ramas ?array)

    (change_turn ?t)
)

(defrule nota-baja-software
    (declare (salience 99))
    ?r <- (Respuestas (nota baja) (software SI))
    ?t <- (next-turn (next ?z) )

    (prefiere_software)
    (nota_baja)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (borrar_valor ?user "CSI")
    ;;(imprimir_ramas ?array)

    (change_turn ?t)
)
(defrule nota-baja-hardware
    (declare (salience 99))
    ?r <- (Respuestas (nota baja) (software NO))
    ?t <- (next-turn (next ?z) )

    (prefiere_hardware)
    (nota_baja)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (borrar_valor ?user "SI")
    ;;(imprimir_ramas ?array)

    (change_turn ?t)
)

;;;; #####################################################################

(defrule teoria_positivo_software
    (declare (salience 99))
    ?r <- (Respuestas (teoria SI) (software SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (teoria SI)
    (prefiere_software)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_teoria) )
    (borrar_valor ?user "IS")
    (printout t "Es de suma importancia saber el porqué de las cosas!" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "te gusta la teoría por detrás de las cosas")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "te gusta la teoría por detrás de las cosas" ?a )))
)

(defrule teoria_positivo_hardware
    (declare (salience 99))
    ?r <- (Respuestas (teoria SI) (software NO))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (teoria SI)
    (prefiere_hardware)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_teoria) )
    (borrar_valor ?user "TI")
    (borrar_valor ?user "IC")
    (printout t "Es de suma importancia saber el porqué de las cosas!" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "te gusta la teoría por detrás de las cosas")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "te gusta la teoría por detrás de las cosas" ?a )))
)

(defrule teoria_positivo
    (declare (salience 99))
    ?f <- (teoria SI)
    =>
    (retract ?f)
    (assert (prefiere_teoria) )
    (printout t "Es de suma importancia saber el porqué de las cosas!" crlf)
)

(defrule teoria_negativo
    (declare (salience 99))
    ?r <- (Respuestas (teoria NO))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (teoria NO)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "CSI")
    (borrar_valor ?user "SI")
    (printout t "El ponerse a programar es de las mejores sensaciones, estoy de acuerdo!" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "eres más de ponerle a prueba lo que te enseñan")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "eres más de ponerle a prueba lo que te enseñan" ?a )))
)

;;;; #####################################################################

(defrule base_de_datos_positivo
    (declare (salience 99))
    ?r <- (Respuestas (base_de_datos SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (base_de_datos SI)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "IC")
    (borrar_valor ?user "CSI")
    (borrar_valor ?user "IS")
    (printout t "Yo la verdad que no soy muy fan de sql...algún día quizás cambie de opinión." crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "eres de los que les gustan las bases de datos")

    (change_turn ?t)
     ;; (modify ?j (just1 (str-cat "eres de los que les gustan las bases de datos" ?a )))
)

(defrule base_de_datos_negativo
    (declare (salience 99))
    ?r <- (Respuestas (base_de_datos NO))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (base_de_datos NO)
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "SI")
    (borrar_valor ?user "TI")
    (printout t "Yo tampoco soy muy fan que digamos de sql...algún día quizás cambie de opinión." crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "eres como yo y no te va mucho las bases de datos")

    (change_turn ?t)
    ;; (modify ?j (just1 (str-cat "eres como yo y no te va mucho las bases de datos" ?a )))
)

;;;; #####################################################################

(defrule programar_alto_teoria
    (declare (salience 99))
    ?r <- (Respuestas (teoria SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    (prefiere_teoria)
    ?f <- (programar ?n)
    (or
        (and
            (test (eq (type ?n) (type 1) ) )
            (test (and (>= ?n 4) (<= ?n 5) ) )
        )
        (test (eq ?n SI))
    )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_programar))
    (borrar_valor ?user "SI")
    (printout t "No te olvides de utilizar neovim!" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "adoras programar y desarrollar proyectos")

    (change_turn ?t)
    (modify ?r (programar SI))
     ;; (modify ?j (just1 (str-cat "adoras programar y desarrollar proyectos" ?a )))
)

(defrule programar_bajo_teoria
    (declare (salience 99))
    ?r <- (Respuestas (teoria SI))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    (prefiere_teoria)
    ?f <- (programar ?n)
    (or
        (and
            (test (eq (type ?n) (type 1) ) )
            (test (and (>= ?n 4) (<= ?n 5) ) )
        )
        (test (eq ?n SI))
    )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "CSI")
    (printout t "Quizás te guste si aprendes a usar vim.." crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "no eres muy fan de programar")

    (change_turn ?t)
    (modify ?r (programar NO))
     ;;(modify ?j (just1 (str-cat "no eres muy fan de programar" ?a )))
)

(defrule programar_alto
    (declare (salience 99))
    ?r <- (Respuestas (programar UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (programar ?n)
    (or
        (and
            (test (eq (type ?n) (type 1) ) )
            (test (and (>= ?n 4) (<= ?n 5) ) )
        )
        (test (eq ?n SI))
    )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_programar) )
    (borrar_valor ?user "TI")
    (printout t "Echadle un vistazo a neovim, igual te gusta!" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "te encanta programar")

    (change_turn ?t)
    (modify ?r (programar SI))
    ;;(modify ?j (just1 (str-cat "te encanta programar" ?a )))
)

(defrule programar_bajo
    (declare (salience 99))

    ?r <- (Respuestas (programar UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (programar ?n)
    (or
        (and
            (test (eq (type ?n) (type 1) ) )
            (test (and (>= ?n 4) (<= ?n 5) ) )
        )
        (test (eq ?n SI))
    )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "SI")
    (printout t "Quizás te guste si aprendes a usar vim.." crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "no te hace mucha ilusión programar")

    (change_turn ?t)
    (modify ?r (programar SI))
    ;;(modify ?j (just1 (str-cat "no te hace mucha ilusión programar" ?a )))
)

;;;; #####################################################################

(defrule ejemplos_fisicos_alto
    (declare (salience 99))

    ?r <- (Respuestas (ejemplos_fisicos UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (ejemplos_fisicos ?n)
    (test (not (eq ?n UNKNOWN) ) )
    (test (and (>= ?n 3) (<= ?n 5) ) )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (assert (prefiere_ejemplos_fisicos))
    (borrar_valor ?user "TI")
    (borrar_valor ?user "SI")
    (printout t "A mi casi me convence la idea de los robots, no te voy a engañar :P" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "te gustaría ver robots, gráficas y ejemplos de lo que haces")

    (change_turn ?t)
    (modify ?r (ejemplos_fisicos SI))
    ;;(modify ?j (just1 (str-cat "te gustaría ver robots, gráficas y ejemplos de lo que haces" ?a )))
)

(defrule ejemplos_fisicos_bajo
    (declare (salience 99))
    ?r <- (Respuestas (ejemplos_fisicos UNKNOWN))
    ?t <- (next-turn (next ?z) )
    ?j <- (razones (just1 ?a))

    ?f <- (ejemplos_fisicos ?n)
    (test (not (eq ?n UNKNOWN) ) )
    (test (and (>= ?n 1) (<= ?n 2) ) )
    ?user <- (object (is-a USER)(lista $?array))
    =>
    (retract ?f)
    (borrar_valor ?user "IC")
    (printout t "A mi casi me convence la idea de los robots, no te voy a engañar :P" crlf)
    ;;(imprimir_ramas ?array)
    (insertar_explicacion ?user "no te importa tanto la estética si no apenas lo que hace")
    (change_turn ?t)
    (modify ?r (ejemplos_fisicos NO))
    ;;(modify ?j (just1 (str-cat "no te importa tanto la estética si no apenas lo que hace" ?a )))
)

;;;; #####################################################################

;; Verificamos si el tamaño de la lista ya es de apenas una rama para terminar antes

(defrule finished_by_size
    (declare (salience 100))
    ?e <- (estados (estadoA ?a))

    ?user <- (object (is-a USER) (lista $?array) )
    (test (eq (length$ ?array ) 1) )
    =>
    (assert (finished) )

    (modify ?e (estadoA TERMINADO))
    ;;(imprimir_ramas ?array)
)

;; Verificamos si ya hemos realizado todas las preguntas.

(defrule finished_by_question
    (declare (salience 100))
    (ask_software DONE)
    (ask_matematicas DONE)
    (ask_programar DONE)
    (ask_teoria DONE)
    (ask_notas DONE)
    (ask_base_de_datos DONE)
    (ask_ejemplos_fisicos DONE)
    ?e <- (estados (estadoA ?a))
    =>
    (assert (finished) )
    (modify ?e (estadoA TERMINADO))
)

;;;; #####################################################################
;;;; #####################################################################

(defrule finished
    (declare (salience 100))
    (finished)
    (not (and (software ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (matematicas ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (programar ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (teoria ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (notas ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (base_de_datos ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    (not (and (ejemplos_fisicos ?x) (test (not (eq ?x UNKNOWN ) ) ) ) )
    ?user <- (object (is-a USER) (lista $?array) )
    ?e <- (estados (estadoA ?a))
    =>
    (decidir_y_explicar ?user)
    (modify ?e (estadoA TERMINADO))

)

(defrule TERMINADOS
(declare (salience 9999))
;; Todos vamos a tener esta regla también...
;; Como no sabemos que módulo será el último, forzaremos a que todos puedan decidir imprimir cuando todos terminen
    ?e <- (estados
        (estadoA TERMINADO)
        (estadoB TERMINADO)
      )
    =>
    (focus IMPRIMIR)
)

(defrule not_changed
    (declare (salience -9999))
    ?t <- (next-turn (next ?x))
    (not (estados
                (estadoA TERMINADO)
                (estadoB TERMINADO) )
    )
    =>
    (change_turn ?t)
)

;;;; #####################################################################

(defmodule B (import A deftemplate Respuestas   )
             (import A deftemplate next-turn    )
             (import A deftemplate decisiones   )
             (import A deftemplate razones      )
             (import A deftemplate estados      ) )

;;Definimos los hechos para cada rama
(deffacts Ramas
(Rama Computacion_y_Sistemas_Inteligentes)
(Rama Ingenieria_del_Software)
(Rama Ingenieria_de_Computadores)
(Rama Sistemas_de_informacion)
(Rama Tecnologias_de_la_informacion)
)



(deffunction change_turn (?x)
    (if
    (eq (fact-slot-value ?x next) true)
    then
        (modify ?x (preguntado false)) (modify ?x (next false)) (focus A)
    else
        (modify ?x (next true))
    )
)


;;Puntuaciones que le asignamos a cada rama dependiendo de la respuesta del usuario

;;Para CSI hay que ser trabajador,nos tienen que gustar las mates(lo mas importante), y saber programar
(deffacts gustaRamaCSI
 (gusta csi matematicas BIEN 100)
 (gusta csi matematicas REGULAR 10)
 (gusta csi matematicas MAL -200)
 (gusta csi matematicas NOLOSE 0)

 (gusta csi programara BIEN 50)
 (gusta csi programara REGULAR 10)
 (gusta csi programara MAL -30)
 (gusta csi programara NOLOSE 0)

 (gusta csi hardware SI -200)
 (gusta csi hardware NO 10)
 (gusta csi hardware NOLOSE 0)

 (gusta csi notamedia ALTA 40)
 (gusta csi notamedia MEDIA 10)
 (gusta csi notamedia BAJA -20)
 (gusta csi notamedia NOLOSE 0)

 (gusta csi trabajador SI 40)
 (gusta csi trabajador NO -30)
 (gusta csi trabajador NOLOSE 0)

)

;;Lo más carácteristico de IS es saber programar
(deffacts gustaRamaIS
 (gusta is matematicas BIEN -20)
 (gusta is matematicas REGULAR -10)
 (gusta is matematicas MAL 60)
 (gusta is matematicas NOLOSE 0)

 (gusta is programara BIEN 100)
 (gusta is programara REGULAR 20)
 (gusta is programara MAL -100)
 (gusta is programara NOLOSE 0)

 (gusta is hardware SI -200)
 (gusta is hardware NO 10)
 (gusta is hardware NOLOSE 0)

 (gusta is notamedia ALTA 20)
 (gusta is notamedia MEDIA 10)
 (gusta is notamedia BAJA 0)
 (gusta is notamedia NOLOSE 0)

 (gusta is trabajador SI 20)
 (gusta is trabajador NO -10)
 (gusta is trabajador NOLOSE 0)

)

;;Lo mas caracteristico de IC es que nos guste el hardware
(deffacts gustaRamaIC
 (gusta ic matematicas BIEN 10)
 (gusta ic matematicas REGULAR 5)
 (gusta ic matematicas MAL 0)
 (gusta ic matematicas NOLOSE 0)

 (gusta ic programara BIEN 10)
 (gusta ic programara REGULAR 5)
 (gusta ic programara MAL 0)
 (gusta ic programara NOLOSE 0)

 (gusta ic hardware SI 200)
 (gusta ic hardware NO -100)
 (gusta ic hardware NOLOSE 0)

 (gusta ic notamedia ALTA 30)
 (gusta ic notamedia MEDIA 10)
 (gusta ic notamedia BAJA 5)
 (gusta ic notamedia NOLOSE 0)

 (gusta ic trabajador SI 40)
 (gusta ic trabajador NO -30)
 (gusta ic trabajador NOLOSE 0)

)

;;La rama de SI y TI no se muy BIEN sus diferencias, ya que me parecen bastante parecidas, por lo que pondre que en TI hay que trabajar menos,se programa menos y hay algo mas de hardware
(deffacts gustaRamaSI
 (gusta si matematicas BIEN -50)
 (gusta si matematicas REGULAR -20)
 (gusta si matematicas MAL 50)
 (gusta si matematicas NOLOSE 0)

 (gusta si programara BIEN 50)
 (gusta si programara REGULAR 10)
 (gusta si programara MAL -5)
 (gusta si programara NOLOSE 0)

 (gusta si hardware SI 5)
 (gusta si hardware NO -5)
 (gusta si hardware NOLOSE 0)

 (gusta si notamedia ALTA 5)
 (gusta si notamedia MEDIA 15)
 (gusta si notamedia BAJA 30)
 (gusta si notamedia NOLOSE 0)

 (gusta si trabajador SI 40)
 (gusta si trabajador NO -10)
 (gusta si trabajador NOLOSE 0)

)

;;Parecido a SI pero siendo menos trabajador y con menos importancia programar
(deffacts gustaRamaTI
 (gusta ti matematicas BIEN -50)
 (gusta ti matematicas REGULAR -20)
 (gusta ti matematicas MAL 50)
 (gusta ti matematicas NOLOSE 0)

 (gusta ti programara BIEN 5)
 (gusta ti programara REGULAR 10)
 (gusta ti programara MAL 20)
 (gusta ti programara NOLOSE 0)

 (gusta ti hardware SI 15)
 (gusta ti hardware NO 10)
 (gusta ti hardware NOLOSE 0)

 (gusta ti notamedia ALTA 5)
 (gusta ti notamedia MEDIA 15)
 (gusta ti notamedia BAJA 30)
 (gusta ti notamedia NOLOSE 0)

 (gusta ti trabajador SI 10)
 (gusta ti trabajador NO 5)
 (gusta ti trabajador NOLOSE 0)
)


;;Inicializamos las ramas que acabaremos recomendando a 0 y ponemos empezado como verdadero
(defrule inicializar
(declare (salience 9999))
(not(empezado))
(not(yaaconsejado))
=>
(assert(empezado)(recomendamos csi 0)(recomendamos is 0)(recomendamos ic 0)(recomendamos ti 0)(recomendamos si 0))
)

;;Preguntamos al usuario como se le dan las matematicas
(defrule preguntamosmates
?r <- (Respuestas (matematicas UNKNOWN))
?t <- (next-turn (preguntado false))
(not (yaaconsejado))
(not (aptitud mates ?val))
(not (yarespondido))
=>
(printout t "¿Como se te dan las matematicas? (bien,mal,regular,no_se)" crlf)
(assert (aptitud mates (upcase (read))))
(modify ?t (preguntado true))
(change_turn ?t)
)

(defrule cambiadomates
    (declare (salience -4004) )
    ?r <- (Respuestas (matematicas ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    (not (aptitud mates ?otro) )
    =>
    (assert (aptitud mates ?algo) )
)

(defrule asignamosmates
(declare (salience -9990))
(aptitud mates ?val)
(not (gustamates ?algo) )
=>
(assert (gustamates ?val))
)

(defrule comprobacionbienmates
?r <- (Respuestas (matematicas UNKNOWN))
(gustamates ?val)
(test (eq ?val BIEN))
=>
(assert (gustamates SI))
(modify ?r (matematicas SI))
)

(defrule comprobacionmalregularmates
?r <- (Respuestas (matematicas UNKNOWN))
(gustamates ?val)
(test (or(eq ?val MAL)(eq ?val REGULAR)))
=>
(assert (gustamates NO))
(modify ?r (matematicas NO))
)

;;Preguntamos al usuario como se le da la programacion
(defrule preguntamosprogramar
(declare (salience -9991))
?r <- (Respuestas (programar UNKNOWN))
?t <- (next-turn (preguntado false))

(not (yaaconsejado))
(not (aptitud programara ?val))
(not (yarespondido))
=>
(printout t "¿Como se te da la programacion? (bien,mal,regular,no_se)" crlf)
(assert (aptitud programara (upcase (read))))
(modify ?t (preguntado true))
(change_turn ?t)
)

(defrule cambiadoprogramar
    (declare (salience 9999) )
    ?r <- (Respuestas (programar ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    (not (aptitud programara ?val))
    =>
    (assert (aptitud programara ?algo) )
)

(defrule asignamosprogramar
    (declare (salience 9000) )
    (aptitud programara ?val)
    (not (gustaprogramar ?algo))
=>
    (assert (gustaprogramar ?val))
)

(defrule comprobacionbienprogramar
    (declare (salience 9999) )
?r <- (Respuestas (programar UNKNOWN))
(gustaprogramar ?val)
(test (eq ?val BIEN))
=>
(assert (gustaprogramar SI))
(modify ?r (programar SI))
)

(defrule comprobacionmalregularprogamar
    (declare (salience 9999) )
?r <- (Respuestas (programar UNKNOWN))
(gustaprogramar ?val)
(test (or(eq ?val MAL)(eq ?val REGULAR)))
=>
(assert (gustaprogramar NO))
(modify ?r (programar NO))
)

;;Preguntamos al usuario si le gusta el hardware
(defrule preguntamoshardware
(declare (salience -9992))
?r <- (Respuestas (software UNKNOWN))
?t <- (next-turn (preguntado false))

(not (yaaconsejado))
(not (gusta hardware ?val))
(not (yarespondido))
=>
(printout t "¿Te gusta el hardware? (si,no,no_se)" crlf)
(bind ?res (upcase (read)) )
(assert (gusta hardware ?res ))
(modify ?r (software ?res) )
(modify ?t (preguntado true))
(change_turn ?t)
)

(defrule cambiadoprogramar
    (declare (salience 9999) )
    ?r <- (Respuestas (software ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    (not (gusta hardware ?val))
    =>
    (assert (gusta hardware ?algo) )
)

;;Preguntamos su nota media al usuario
(defrule preguntanota
(declare (salience -9993))
?r <- (Respuestas (nota UNKNOWN))
?t <- (next-turn (preguntado false))
(not (yaaconsejado))
(not (nota ?val))
(not (yarespondido))
=>
(printout t "¿Como es tu nota media? (alta [8-10] , media [6-8] , baja [0-6],no_se)" crlf)
(bind ?res (upcase (read)) )
(assert (nota ?res))
(modify ?r (nota ?res) )
(modify ?t (preguntado true))
(change_turn ?t)
)

(defrule cambiadonota
    (declare (salience 9999) )
    ?r <- (Respuestas (nota ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    (not (nota ?val))
    =>
    (assert (nota ?algo) )
)
;;Preguntamos al usuario si se considera trabajador
(defrule preguntatrabajador
(declare (salience -9994))
?r <- (Respuestas (trabajador UNKNOWN))
?t <- (next-turn (preguntado false))
(not (yaaconsejado))
(not (trabajador ?val))
(not (yarespondido))
=>
(printout t "¿Eres una persona trabajadora? (si,no,nolose)" crlf)
(bind ?res (upcase (read)) )
(assert (trabajador ?res))
(modify ?r (trabajador ?res))
(modify ?t (preguntado true))
(change_turn ?t)
)

(defrule cambiadotrabajador
    (declare (salience 9999) )
    ?r <- (Respuestas (trabajador ?algo) )
    (not (test (eq ?algo UNKNOWN) ) )
    (not (trabajador ?val))
    =>
    (assert (trabajador ?algo) )
)

;;Comprobamos la respuesta para programacion y matematicas
(defrule comprobarentradamatematicasprogramacion
(declare (salience 9999))
(not (yaaconsejado))
?x <- (aptitud ?algo ?valor)
(test(and(neq ?valor BIEN)(and (neq ?valor MAL)(and (neq ?valor REGULAR)(neq ?valor NOLOSE)))))
=>
(printout t "Por favor responde bien, regular, mal,nolose" crlf)
(retract ?x)
)

;;Comprobamos la respuesta de hardware
(defrule comprobarentradahardware
(declare (salience 9999))
(not (yaaconsejado))
?x <- (gusta hardware ?valor)
(test(and(neq ?valor SI)(and (neq ?valor NO)(neq ?valor NOLOSE))))
=>
(printout t "Por favor responde si, no,nolose" crlf)
(retract ?x)
)

;;Comprobamos la respuesta de ser trabajador
(defrule comprobarentradatrabajador
(declare (salience 9999))
(not (yaaconsejado))
?x <- (trabajador ?valor)
(test(and(neq ?valor SI)(and (neq ?valor NO)(neq ?valor NOLOSE))))
=>
(printout t "Por favor responde si, no,nolose" crlf)
(retract ?x)
)

;;Comprobamos como es su nota media
(defrule comprobarentradanota
(declare (salience 9999))
(not (yaaconsejado))
?x <- (nota ?valor)
(test(and(neq ?valor ALTA)(and (neq ?valor MEDIA)(and (neq ?valor BAJA)(neq ?valor NOLOSE)))))
=>
(printout t "Por favor responde alta,media,baja,nolose" crlf)
(retract ?x)
)

;;Vemos si ya ha respondido todas las respuestas el usuario
(defrule harespondidotodo
(declare (salience 9990))
?e <- (estados (estadoB ?a))
(not (todorespondido))
(aptitud mates ?val1)
(aptitud programara ?val2)
(gusta hardware ?val3)
(nota ?val4)
(trabajador ?val5)
=>
(assert (todorespondido))
(modify ?e (estadoB TERMINADO))
)


;;Puntuamos las matematicas en todas las ramas
(defrule puntuamosmates
(declare (salience 8000))
(aptitud mates ?val)
?x <- (recomendamos ?rama ?puntuacion)
;; Instanciar
?t <- (next-turn (next ?cam))

(gusta ?rama matematicas ?val ?valor)
(not (matespuntuado ?rama))
=>
(retract ?x)
(assert(recomendamos ?rama (+ ?puntuacion ?valor))(matespuntuado ?rama))
)

(defrule TerminadoPuntuarMates
    (declare (salience -9999))
    (matespuntuado ic)
    (matespuntuado csi)
    (matespuntuado si)
    (matespuntuado ti)
    (matespuntuado is)
    ?t <- (next-turn (next ?a ) )
    (not (TerminadoPuntuarMates))
    =>
    (change_turn ?t)
    (assert (TerminadoPuntuarMates))
)

;;Puntuamos la programacion en todas las ramas
(defrule puntuamosprogramar
(declare (salience 8000))
(aptitud programara ?val)
?x <- (recomendamos ?rama ?puntuacion)
;; Instanciar
?t <- (next-turn (next ?cam))

(gusta ?rama programara ?val ?valor)
(not (programarpuntuado ?rama))
=>
(retract ?x)
(assert(recomendamos ?rama (+ ?puntuacion ?valor))(programarpuntuado ?rama))
)

(defrule TerminadoPuntuarProg
    (declare (salience -9999))
    (programarpuntuado ic)
    (programarpuntuado csi)
    (programarpuntuado si)
    (programarpuntuado ti)
    (programarpuntuado is)
    (not (TerminadoPuntuarProg))
    ?t <- (next-turn (next ?a ) )
    =>
    (assert (TerminadoPuntuarProg))
    (change_turn ?t)
)

;;Puntuamos el hardware en todas las ramas
(defrule puntuamoshardware
(declare (salience 8000))
(gusta hardware ?val)
?x <- (recomendamos ?rama ?puntuacion)
;; Instanciar
?t <- (next-turn (next ?cam))
(gusta ?rama hardware ?val ?valor)
(not (hardwarepuntuado ?rama))
=>
(retract ?x)
(assert(recomendamos ?rama (+ ?puntuacion ?valor))(hardwarepuntuado ?rama))
)

(defrule TerminadoPuntuarhard
    (declare (salience -9999))
    (hardwarepuntuado ic)
    (hardwarepuntuado csi)
    (hardwarepuntuado si)
    (hardwarepuntuado ti)
    (hardwarepuntuado is)
    (not (TerminadoPuntuarhard))
    ?t <- (next-turn (next ?a ) )
    =>
    (assert (TerminadoPuntuarhard))
    (change_turn ?t)
)

;;Puntuamos la nota media en todas las ramas
(defrule puntuamosnota
(declare (salience 8000))
(nota ?val)
?x <- (recomendamos ?rama ?puntuacion)
;; Instanciar
?t <- (next-turn (next ?cam))
(gusta ?rama notamedia ?val ?valor)
(not (notapuntuada ?rama))
=>
(retract ?x)
(assert(recomendamos ?rama (+ ?puntuacion ?valor))(notapuntuada ?rama))
)

(defrule TerminadoPuntuarNota
    (declare (salience -9999))
    (notapuntuada ic)
    (notapuntuada csi)
    (notapuntuada si)
    (notapuntuada ti)
    (notapuntuada is)
    (not (TerminadoPuntuarNota))
    ?t <- (next-turn (next ?a ) )
    =>
    (assert (TerminadoPuntuarNota))
    (change_turn ?t)
)


;;Puntuamos si es trabajador en todas las ramas
(defrule puntuamostrabajador
(declare (salience 8000))
(trabajador ?val)
?x <- (recomendamos ?rama ?puntuacion)
;; Instanciar
?t <- (next-turn (next ?cam))

(gusta ?rama trabajador ?val ?valor)
(not (trabajadorpuntuado ?rama))
=>
(retract ?x)
(assert(recomendamos ?rama (+ ?puntuacion ?valor))(trabajadorpuntuado ?rama))
)

(defrule TerminadoPuntuarTrab
    (declare (salience -9999))
    (trabajadorpuntuado ic)
    (trabajadorpuntuado csi)
    (trabajadorpuntuado si)
    (trabajadorpuntuado ti)
    (trabajadorpuntuado is)
    (not (TerminadoPuntuarTrab))
    ?t <- (next-turn (next ?a ) )
    =>
    (assert (TerminadoPuntuarTrab))
    (change_turn ?t)
)


;;;Recomendamos la rama elegida y decimos el motivo de la eleccion cuando el usuario ha contestado todas las preguntas


;;Si la puntuacion de csi es mayor que las demas la recomendamos
(defrule recomendamoscsi
(todorespondido)
(not (yaaconsejado))
(recomendamos csi ?val1)
(recomendamos ic ?val2)
(recomendamos is ?val3)
(recomendamos si ?val4)
(recomendamos ti ?val5)
(test(and(> ?val1 ?val2)(and(> ?val1 ?val3)(and(> ?val1 ?val4)(> ?val1 ?val5)))))
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )
=>
(assert (Consejo Computacion_y_Sistemas_Inteligentes "te encantan las matematicas "))
(modify ?j (just2 "te encantan las matematicas ") )
(modify ?d (desc2 "Computación y Sistemas Inteligentes") )
)

;;Si la puntuacion de is es mayor que las demas la recomendamos
(defrule recomendamosis
(todorespondido)
(not (yaaconsejado))
(recomendamos is ?val1)
(recomendamos ic ?val2)
(recomendamos csi ?val3)
(recomendamos si ?val4)
(recomendamos ti ?val5)
(test(and(> ?val1 ?val2)(and(> ?val1 ?val3)(and(> ?val1 ?val4)(> ?val1 ?val5)))))
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )
=>
(assert (Consejo Ingenieria_del_Software "te gusta programar y no tanto las matematicas"))
(modify ?j (just2 "te gusta programar y no tanto las matematicas") )
(modify ?d (desc2 "Ingeniería del Software") )
)

;;Si la puntuacion de ic es mayor que las demas la recomendamos
(defrule recomendamosic
(todorespondido)
(not (yaaconsejado))
(recomendamos ic ?val1)
(recomendamos is ?val2)
(recomendamos csi ?val3)
(recomendamos si ?val4)
(recomendamos ti ?val5)
(test(and(> ?val1 ?val2)(and(> ?val1 ?val3)(and(> ?val1 ?val4)(> ?val1 ?val5)))))
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )
=>
(assert (Consejo Ingenieria_de_Computadores "te encanta el hardware"))
(modify ?j (just2 "te encanta el hardware") )
(modify ?d (desc2 "Ingeniería de Computadores") )
)

;;Si la puntuacion de si es mayor que las demas la recomendamos
(defrule recomendamossi
(todorespondido)
(not (yaaconsejado))
(recomendamos si ?val1)
(recomendamos ic ?val2)
(recomendamos csi ?val3)
(recomendamos is ?val4)
(recomendamos ti ?val5)
(test(and(> ?val1 ?val2)(and(> ?val1 ?val3)(and(> ?val1 ?val4)(> ?val1 ?val5)))))
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )
=>
(assert (Consejo Sistemas_de_informacion "no te gustan las matematicas, te gusta programar(pero no tanto como para IS) y eres trabajador"))
(modify ?j (just2 "no te gustan las matematicas, te gusta programar(pero no tanto como para IS) y eres trabajador") )
(modify ?d (desc2 "Sistemas de información") )
)

;;Si la puntuacion de ti es mayor que las demas la recomendamos
(defrule recomendamosti
(todorespondido)
(not (yaaconsejado))
(recomendamos ti ?val1)
(recomendamos ic ?val2)
(recomendamos csi ?val3)
(recomendamos si ?val4)
(recomendamos is ?val5)
(test(and(> ?val1 ?val2)(and(> ?val1 ?val3)(and(> ?val1 ?val4)(> ?val1 ?val5)))))
;; Instanciamos razones -> Modulo B = just2
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )

=>
(assert (Consejo Tecnologias_de_la_informacion "se te dan mal las matematicas, no se te da muy bien programar y no eres tan trabajador"))
(modify ?j (just2 "se te dan mal las matematicas, no se te da muy bien programar y no eres tan trabajador") )
(modify ?d (desc2 "Tecnologías de la Información") )
)

;;Si la puntuacion de una rama es igual a las demas(porque el usuario por ejemplo ha contestado a todo no_se) recomendamos CSI porque es la rama en la que me encuentro, es como la rama por defecto
(defrule recomendamosconempate
(todorespondido)
(not (yaaconsejado))
(recomendamos ti ?val1)
(recomendamos ic ?val2)
(recomendamos csi ?val3)
(recomendamos si ?val4)
(recomendamos is ?val5)
(test(and(= ?val1 ?val2)(and(= ?val1 ?val3)(and(= ?val1 ?val4)(= ?val1 ?val5)))))
;; Instanciamos razones -> Modulo B = just2
?j <- (razones (just2 ?b))
?d <- (decisiones (desc2 ?c) )

=>
;; Justificacioens

(assert (Consejo Computacion_y_Sistemas_Inteligentes "como no sabemos exactamente tus gustos, te recomiendo mi rama favorita"))
(modify ?j (just2 "como no sabemos exactamente tus gustos, te recomiendo mi rama favorita") )
(modify ?d (desc2 "Computación y Sistemas Inteligentes") )
)


;;Regla para aconsejar la rama elegida por la mayor puntuación
(defrule ramaaconsejada
(declare (salience 9995))
(not (yaaconsejado))
?e <- (estados (estadoB ?a))
(Consejo ?rama ?motivo)
=>
;;(printout t "Te aconsejamos la rama " ?rama " porque " ?motivo crlf)
(assert (yaaconsejado))
(modify ?e (estadoB TERMINADO))
)

(defrule TERMINADOS
    (declare (salience 9999))
    ?e <- (estados
        (estadoA TERMINADO)
        (estadoB TERMINADO)
      )
    =>
    (focus IMPRIMIR)
)

(defmodule IMPRIMIR (import A deftemplate razones)
                    (import A deftemplate decisiones))

;; https://stackoverflow.com/questions/45896221/clips-how-to-add-line-breaks-into-a-sentence
(deffunction print-to-width (?log-name ?width ?str)
  (if (<= ?width 0)
     then
     (printout ?log-name ?str crlf)
     (return))
  (bind ?w ?width)
  (while (neq ?str "")
     (bind ?pos (str-index " " ?str))
     (if (or (not ?pos)
             (> ?pos (+ ?w 1)))
        then
        (if (and (not ?pos) (<= (str-length ?str) ?w))
           then
           (printout ?log-name ?str)
           (bind ?str "")
           else
           (if (!= ?w ?width)
              then
              (printout ?log-name crlf)
              (bind ?w ?width)
              else
              (printout ?log-name (sub-string 1 ?w ?str))
              (bind ?str (sub-string (+ ?w 1) (str-length ?str) ?str))
              (if (neq ?str "") then (printout ?log-name crlf))
              (bind ?w ?width)))
        else
        (printout ?log-name (sub-string 1 ?pos ?str))
        (bind ?str (sub-string (+ ?pos 1) (str-length ?str) ?str))
        (bind ?w (- ?w ?pos)))
     (if (eq ?str "") then (printout ?log-name crlf)))
     (return)
)

(defrule imprimision1
    (declare (salience -9999))
    (not (printed1))
    ?r <- (razones (just1 ?a) )
    (test (not (eq ?a "")))
    ?d <- (decisiones (desc1 ?b))
    (test (not (eq ?b "")))
    =>
    (printout t "################## Experto 1 ###################" crlf)
    (printout t "El experto 1, Brian,  dice que: ")
    (print-to-width t 50 ?b )
    (printout t "Y además justifica que es debido a que: ")
    (print-to-width t 50 ?a )
    (assert (printed1))
    (printout t "################################################" crlf)
)

(defrule imprimision2
    (declare (salience -9999))
    (printed1)
    (not (printed2))
    ?r <- (razones (just2 ?a) )
    (test (not (eq ?a "")))
    ?d <- (decisiones (desc2 ?b))
    (test (not (eq ?b "")))
    =>
    (printout t "################## Experto 2 ###################" crlf)
    (printout t "El experto 2, Fernando,  dice que: ")
    (print-to-width t 50 ?b )
    (printout t "Y además explica que es debido a que: ")
    (print-to-width t 50 ?a )
    (printout t "################################################" crlf)
    (assert (printed2))
)

