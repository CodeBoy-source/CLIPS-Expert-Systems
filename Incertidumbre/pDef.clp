(defrule initialize
(declare (salience 9998))
    =>
    (printout t "Bienvenido lo por defecto de Brian Sena" crlf)
    (printout t "Intentaremos solventar sus dudas sobre los animales voladores" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;; Representación  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (ave ?x) Representa "?x es un ave"
; (animal ?x) Representa "?x es un animal"
; (vuela ?x si|no seguro|por_defecto) representa "?x vuele si|no con esa certeza"

;;;;;;;;;;;;;;;;;;;;;;;; Hechos ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts datos
    (ave gorrion) (ave paloma) (ave aguila) (ave pinguino)
    (mamifero vaca) (mamifero perror) (mamifero caballo)
    (vuela pinguino no seguro)
)

;;;;;;;;;;;;;;;;;;;;;;;;; Reglas Seguras ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule aves_son_animales
    (ave ?x)
    =>
    (assert (animal ?x) )
    (bind ?expl (str-cat "Es un animal, porque las aves son un tipo de animal"))
    (assert (explicacion animal ?x ?expl) )
)

(defrule mamiferos_son_animales
    (mamifero ?x)
    =>
    (assert (animal ?x) )
    (bind ?expl (str-cat "Es un animal, porque los mamiferos son un tipo de animal"))
    (assert (explicacion animal ?x ?expl))
)

(defrule ave_vuela_por_defecto
    (declare (salience -1))
    (ave ?x)
    =>
    (assert (vuela ?x si por_defecto))
    (bind ?expl (str-cat "Vuela, porque casi todas las aves vuelan"))
    (assert (explicacion vuela ?x ?expl))
    (assert (bird_bydefault ?x) )
)

(defrule retract_vuela_por_defecto
    (declare (salience 10) )
    ?f <- (vuela ?x ?r por_defecto)
    (vuela ?x ?s seguro)
    =>
    (retract ?f)
    (bind ?expl (str-cat "Retractamos que un " ?x " " ?r " vuela por defecto, \
porque sabemos seguro que " ?x " " ?s " vuela"))
    (assert (explicacion retracta_vuela ?x ?expl) )
    (assert (retractado ?x) )
)

(defrule mayor_parte_animales_no_vuelan
    (declare (salience -2) )
    (animal ?x)
    (not (vuela ?x ? ? ) )
    =>
    (assert (vuela ?x no por_defecto) )
    (bind ?expl (str-cat "No vuela, porque la mayor parte de \
los animales no vuelan"))
    (assert (animal_bydefault ?x) )
    (assert (explicacion vuela ?x ?expl))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Completando el ejercicio ;;;;;;;;;;;;;;;;;;;;;;;;

(deffunction pregunta (?pregunta $?valores-permitidos)
    (progn$  (?var ?valores-permitidos) (lowcase ?var) )
    (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos) )
    (bind ?respuesta (read))
    (while (not (member$ (upcase ?respuesta) ?valores-permitidos)) do
        (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos))
        (bind ?respuesta (read))
    )
    (bind ?respuesta (lowcase ?respuesta) )
)

(defrule preguntar_animal
    (declare(salience 10))
    (not (preguntado) )
    =>
    (printout t "¿De qué animal le gustaría obtener información? ")
    (bind ?respuesta (read))
    (assert (quiero ?respuesta))
)

(defrule imprimir_animal_conocido
    (declare (salience -5) )
    (quiero ?algo)
    (or (ave ?algo)
        (mamifero ?algo)
        )
    (explicacion animal ?algo ?expl)
    (not (imprimido_animal ?expl))
    =>
    (printout t ?expl crlf)
    (assert (imprimido_animal ?expl))
)

(defrule imprimir_vuela_conocido_animal
    (declare (salience -10) )
    (quiero ?algo)
    (or (ave ?algo)
        (mamifero ?algo)
        )
    (explicacion vuela ?algo ?expl)
    (not (imprimido_vuela_animal ?expl) )
    =>
    (printout t "Resulta qué: " ?expl crlf)
    (assert (imprimido_vuela_animal ?expl))
)

(defrule imprimir_vuela_conocido_animalR
    (declare (salience -20) )
    (quiero ?algo)
    (or (ave ?algo)
        (mamifero ?algo)
        )
    (explicacion retracta_vuela ?algo ?expl)
    (not (imprimido_vuela_animal ?expl) )
    =>
    (printout t "Perdón!!! En realidad: " ?expl crlf)
    (assert (imprimido_vuela_animal ?expl))
)

(defrule No_presente
    (declare (salience 100) )
    (quiero ?algo)
    (not (ave ?algo))
    (not (mamifero ?algo ) )
    (not (preguntado_tipo)  )
    =>
    (bind ?respuesta (pregunta "Resulta que no lo conozco, \
¿Podrías decirme si es un ave o mamifero?" (create$ AVE MAMIFERO NOLOSE) ))
    (assert (preguntado_tipo) )
    (if (eq ?respuesta ave) then (assert (ave ?algo) ) )
    (if (eq ?respuesta mamifero) then (assert (mamifero ?algo) ) )
    (if (eq ?respuesta nolose) then (assert (nolose ?algo) ) )
)

(defrule imprimir_vuela_conocido_animal
    (declare (salience -20) )
    (quiero ?algo)
    (nolose ?algo)
    (not (imprimido_por_defecto ?expl) )
    =>
    (printout t "Diría que al menos un gorila oriental no es" ?expl crlf)
    (assert (imprimido_por_defecto ?expl))
)
