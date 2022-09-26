
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;   RAZONAMIENTO BAYESIANO   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;  EJEMPLO DE SISTEMA CON DOS VARIABLES QUE INFLUYEN Y DOS EFECTOS;;;;;
;;;;;;;;;;;;;;;;;;; Copywright: Juan Luis Castro Peña ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts relaciones_causa_efecto
(influye base_datos DDSI)
(influye redes ISE)
(influye base_datos ISE)
(influye redes FR)

(influye conocimiento IC)
(influye conocimiento AA)

(influye complejidad MAC)
(influye complejidad MC)

(influye algoritmos MH)
(influye algoritmos TSI)

(influye graficos IG)

(influye estudia AA)
(influye estudia IC)
(influye estudia ISE)
(influye estudia MAC)

(influye programar MH)
(influye programar TSI)
(influye programar IG)
(influye programar AA)
(influye programar DDSI)

(influye ejercicios AA)
(influye ejercicios MAC)
(influye ejercicios MC)
(influye ejercicios ISE)
(influye ejercicios FR)
(influye ejercicios DDSI)
)

(deffacts probabilidad_variables_que_influyen
(prob estudia si 0.5)
(prob estudia no 0.5)
(prob programar si 0.5)
(prob programar no 0.5)
(prob ejercicios si 0.5)
(prob ejercicios no 0.5)

(prob base_datos si 0.5)
(prob base_datos no 0.5)
(prob redes si 0.5)
(prob redes no 0.5)
(prob conocimiento si 0.5)
(prob conocimiento no 0.5)
(prob complejidad si 0.5)
(prob complejidad no 0.5)
(prob graficos si 0.5)
(prob graficos no 0.5)
(prob algoritmos si 0.5)
(prob algoritmos no 0.5)
)

(deffacts distribucion_segun_valores_variables_que_influyen

(probcond3 DDSI SI base_datos si programar si ejercicios si 0.70)
(probcond3 DDSI SI base_datos si programar si ejercicios no 0.70)
(probcond2 DDSI SI base_datos si programar si 0.70)
(probcond3 DDSI SI base_datos si programar no ejercicios si 0.60)
(probcond3 DDSI SI base_datos si programar no ejercicios no 0.50)
(probcond2 DDSI SI base_datos si programar no 0.55)
(probcond3 DDSI SI base_datos no programar si ejercicios si 0.20)
(probcond3 DDSI SI base_datos no programar si ejercicios no 0.20)
(probcond2 DDSI SI base_datos no programar si 0.20)
(probcond3 DDSI SI base_datos no programar no ejercicios si 0.10)
(probcond3 DDSI SI base_datos no programar no ejercicios no 0.0)
(probcond2 DDSI SI base_datos no programar no 0.05)

(probcond2 DDSI SI programar si ejercicios si 0.35)
(probcond2 DDSI SI programar si ejercicios no 0.35)
(probcond2 DDSI SI programar no ejercicios si 0.30)
(probcond2 DDSI SI programar no ejercicios no 0.25)
(probcond2 DDSI SI programar si ejercicios si 0.10)
(probcond2 DDSI SI programar si ejercicios no 0.10)
(probcond2 DDSI SI programar no ejercicios si 0.05)
(probcond2 DDSI SI programar no ejercicios no 0.0)

(probcond3 ISE SI redes si estudia si ejercicios si 0.8)
(probcond3 ISE SI redes si estudia si ejercicios no 0.75)
(probcond2 ISE SI redes si estudia si 0.775)
(probcond3 ISE SI redes si estudia no ejercicios si 0.70)
(probcond3 ISE SI redes si estudia no ejercicios no 0.65)
(probcond3 ISE SI redes no estudia si ejercicios si 0.55)
(probcond3 ISE SI redes no estudia si ejercicios no 0.35)
(probcond2 ISE SI redes no estudia si 0.40)
(probcond3 ISE SI redes no estudia no ejercicios si 0.25)
(probcond3 ISE SI redes no estudia no ejercicios no 0.0)
(probcond2 ISE SI redes no estudia no 0.125)

(probcond2 ISE SI estudia si ejercicios si 0.4)
(probcond2 ISE SI estudia si ejercicios no 0.375)
(probcond2 ISE SI estudia no ejercicios si 0.35)
(probcond2 ISE SI estudia no ejercicios no 0.325)
(probcond2 ISE SI estudia si ejercicios si 0.275)
(probcond2 ISE SI estudia si ejercicios no 0.175)
(probcond2 ISE SI estudia no ejercicios si 0.125)
(probcond2 ISE SI estudia no ejercicios no 0.0)

(probcond2 FR SI redes si ejercicios si 0.7)
(probcond2 FR SI redes si ejercicios no 0.7)
(probcond2 FR SI redes no ejercicios si 0.2)
(probcond2 FR SI redes no ejercicios no 0.0)

(probcond2 MC SI complejidad si ejercicios si 0.9)
(probcond2 MC SI complejidad si ejercicios no 0.6)
(probcond2 MC SI complejidad no ejercicios si 0.5)
(probcond2 MC SI complejidad no ejercicios no 0.25)

(probcond2 MAC SI estudia si ejercicios si 0.35)
(probcond2 MAC SI estudia si ejercicios no 0.35)
(probcond2 MAC SI estudia no ejercicios si 0.15)
(probcond2 MAC SI estudia no ejercicios no 0.15)
(probcond2 MAC SI estudia si ejercicios si 0.15)
(probcond2 MAC SI estudia si ejercicios no 0.15)
(probcond2 MAC SI estudia no ejercicios si 0.15)
(probcond2 MAC SI estudia no ejercicios no 0.0)

(probcond2 IC SI estudia si conocimiento si 0.7)
(probcond2 IC SI estudia si conocimiento no 0.5)
(probcond2 IC SI estudia no conocimiento si 0.5)
(probcond2 IC SI estudia no conocimiento no 0.1)

(probcond4 AA SI estudia si conocimiento si programar si ejercicios si 0.80)
(probcond4 AA SI estudia si conocimiento si programar si ejercicios no 0.70)
(probcond3 AA SI estudia si conocimiento si programar si 0.75)

(probcond3 AA SI estudia si programar si ejercicios si 0.40)
(probcond3 AA SI estudia si programar si ejercicios no 0.35)
(probcond2 AA SI estudia si programar si 0.375)

(probcond4 AA SI estudia si conocimiento si programar no ejercicios no 0.70)
(probcond4 AA SI estudia si conocimiento si programar no ejercicios si 0.75)
(probcond3 AA SI estudia si conocimiento si programar no 0.725)
(probcond2 AA SI estudia si conocimiento si 0.7375)

(probcond3 AA SI estudia si programar no ejercicios no 0.35)
(probcond3 AA SI estudia si programar no ejercicios si 0.375)
(probcond2 AA SI estudia si programar no 0.3625)

(probcond4 AA SI estudia si conocimiento no programar si ejercicios si 0.50)
(probcond4 AA SI estudia si conocimiento no programar si ejercicios no 0.40)
(probcond3 AA SI estudia si conocimiento no programar si 0.45)

(probcond4 AA SI estudia si conocimiento no programar no ejercicios si 0.40)
(probcond4 AA SI estudia si conocimiento no programar no ejercicios no 0.30)
(probcond3 AA SI estudia si conocimiento no programar no 0.35)
(probcond2 AA SI estudia si conocimiento no 0.40)

(probcond4 AA SI estudia no conocimiento si programar si ejercicios si 0.3)
(probcond4 AA SI estudia no conocimiento si programar si ejercicios no 0.3)
(probcond3 AA SI estudia no conocimiento si programar si 0.3)

(probcond3 AA SI estudia no programar si ejercicios si 0.15)
(probcond3 AA SI estudia no programar si ejercicios no 0.15)
(probcond2 AA SI estudia no programar si 0.15)

(probcond4 AA SI estudia no conocimiento si programar no ejercicios si 0.3)
(probcond4 AA SI estudia no conocimiento si programar no ejercicios no 0.3)
(probcond3 AA SI estudia no conocimiento si programar no 0.3)
(probcond2 AA SI estudia no conocimiento si 0.3)

(probcond3 AA SI estudia no programar no ejercicios si 0.15)
(probcond3 AA SI estudia no programar no ejercicios no 0.15)
(probcond2 AA SI estudia no programar no 0.15)

(probcond4 AA SI estudia no conocimiento no programar si ejercicios si 0.3)
(probcond4 AA SI estudia no conocimiento no programar si ejercicios no 0.0)
(probcond3 AA SI estudia no conocimiento no programar si 0.0)

(probcond4 AA SI estudia no conocimiento no programar no ejercicios no 0.0)
(probcond4 AA SI estudia no conocimiento no programar no ejercicios si 0.0)
(probcond3 AA SI estudia no conocimiento no programar no 0.0)
(probcond2 AA SI estudia no conocimiento no 0.0)

(probcond2 MH SI algoritmos si programar si 1)
(probcond2 MH SI algoritmos si programar no 0.7)
(probcond2 MH SI algoritmos no programar si 0.7)
(probcond2 MH SI algoritmos no programar no 0.4)

(probcond2 TSI SI algoritmos si programar si 0.6)
(probcond2 TSI SI algoritmos si programar no 0.5)
(probcond2 TSI SI algoritmos no programar si 0.5)
(probcond2 TSI SI algoritmos no programar no 0.0)

(probcond2 IG SI graficos si programar si 0.85)
(probcond2 IG SI graficos si programar no 0.65)
(probcond2 IG SI graficos no programar si 0.50)
(probcond2 IG SI graficos no programar no 0.2)

)

(deffacts probabilidad_efectos
)
; Inicializamos valores para calculos a partir de probcond2
(deffacts inicializacion_probabilidades
(probconj2 DDSI SI estudia si 0)
(probconj2 DDSI SI estudia no 0)
(probconj2 DDSI SI programar si 0)
(probconj2 DDSI SI programar no 0)
(probconj2 DDSI SI ejercicios si 0)
(probconj2 DDSI SI ejercicios no 0)
(probconj2 DDSI SI base_datos si 0)
(probconj2 DDSI SI base_datos no 0)
(probconj2 DDSI SI redes si 0)
(probconj2 DDSI SI redes no 0)
(probconj2 DDSI SI complejidad si 0)
(probconj2 DDSI SI complejidad no 0)
(probconj2 DDSI SI conocimiento si 0)
(probconj2 DDSI SI conocimiento no 0)
(probconj2 DDSI SI algoritmos si 0)
(probconj2 DDSI SI algoritmos no 0)
(probconj2 DDSI SI graficos si 0)
(probconj2 DDSI SI graficos no 0)
(probconj2 ISE SI estudia si 0)
(probconj2 ISE SI estudia no 0)
(probconj2 ISE SI programar si 0)
(probconj2 ISE SI programar no 0)
(probconj2 ISE SI ejercicios si 0)
(probconj2 ISE SI ejercicios no 0)
(probconj2 ISE SI base_datos si 0)
(probconj2 ISE SI base_datos no 0)
(probconj2 ISE SI redes si 0)
(probconj2 ISE SI redes no 0)
(probconj2 ISE SI complejidad si 0)
(probconj2 ISE SI complejidad no 0)
(probconj2 ISE SI conocimiento si 0)
(probconj2 ISE SI conocimiento no 0)
(probconj2 ISE SI algoritmos si 0)
(probconj2 ISE SI algoritmos no 0)
(probconj2 ISE SI graficos si 0)
(probconj2 ISE SI graficos no 0)
(probconj2 FR SI estudia si 0)
(probconj2 FR SI estudia no 0)
(probconj2 FR SI programar si 0)
(probconj2 FR SI programar no 0)
(probconj2 FR SI ejercicios si 0)
(probconj2 FR SI ejercicios no 0)
(probconj2 FR SI base_datos si 0)
(probconj2 FR SI base_datos no 0)
(probconj2 FR SI redes si 0)
(probconj2 FR SI redes no 0)
(probconj2 FR SI complejidad si 0)
(probconj2 FR SI complejidad no 0)
(probconj2 FR SI conocimiento si 0)
(probconj2 FR SI conocimiento no 0)
(probconj2 FR SI algoritmos si 0)
(probconj2 FR SI algoritmos no 0)
(probconj2 FR SI graficos si 0)
(probconj2 FR SI graficos no 0)
(probconj2 MC SI estudia si 0)
(probconj2 MC SI estudia no 0)
(probconj2 MC SI programar si 0)
(probconj2 MC SI programar no 0)
(probconj2 MC SI ejercicios si 0)
(probconj2 MC SI ejercicios no 0)
(probconj2 MC SI base_datos si 0)
(probconj2 MC SI base_datos no 0)
(probconj2 MC SI redes si 0)
(probconj2 MC SI redes no 0)
(probconj2 MC SI complejidad si 0)
(probconj2 MC SI complejidad no 0)
(probconj2 MC SI conocimiento si 0)
(probconj2 MC SI conocimiento no 0)
(probconj2 MC SI algoritmos si 0)
(probconj2 MC SI algoritmos no 0)
(probconj2 MC SI graficos si 0)
(probconj2 MC SI graficos no 0)
(probconj2 MAC SI estudia si 0)
(probconj2 MAC SI estudia no 0)
(probconj2 MAC SI programar si 0)
(probconj2 MAC SI programar no 0)
(probconj2 MAC SI ejercicios si 0)
(probconj2 MAC SI ejercicios no 0)
(probconj2 MAC SI base_datos si 0)
(probconj2 MAC SI base_datos no 0)
(probconj2 MAC SI redes si 0)
(probconj2 MAC SI redes no 0)
(probconj2 MAC SI complejidad si 0)
(probconj2 MAC SI complejidad no 0)
(probconj2 MAC SI conocimiento si 0)
(probconj2 MAC SI conocimiento no 0)
(probconj2 MAC SI algoritmos si 0)
(probconj2 MAC SI algoritmos no 0)
(probconj2 MAC SI graficos si 0)
(probconj2 MAC SI graficos no 0)
(probconj2 IC SI estudia si 0)
(probconj2 IC SI estudia no 0)
(probconj2 IC SI programar si 0)
(probconj2 IC SI programar no 0)
(probconj2 IC SI ejercicios si 0)
(probconj2 IC SI ejercicios no 0)
(probconj2 IC SI base_datos si 0)
(probconj2 IC SI base_datos no 0)
(probconj2 IC SI redes si 0)
(probconj2 IC SI redes no 0)
(probconj2 IC SI complejidad si 0)
(probconj2 IC SI complejidad no 0)
(probconj2 IC SI conocimiento si 0)
(probconj2 IC SI conocimiento no 0)
(probconj2 IC SI algoritmos si 0)
(probconj2 IC SI algoritmos no 0)
(probconj2 IC SI graficos si 0)
(probconj2 IC SI graficos no 0)
(probconj2 AA SI estudia si 0)
(probconj2 AA SI estudia no 0)
(probconj2 AA SI programar si 0)
(probconj2 AA SI programar no 0)
(probconj2 AA SI ejercicios si 0)
(probconj2 AA SI ejercicios no 0)
(probconj2 AA SI base_datos si 0)
(probconj2 AA SI base_datos no 0)
(probconj2 AA SI redes si 0)
(probconj2 AA SI redes no 0)
(probconj2 AA SI complejidad si 0)
(probconj2 AA SI complejidad no 0)
(probconj2 AA SI conocimiento si 0)
(probconj2 AA SI conocimiento no 0)
(probconj2 AA SI algoritmos si 0)
(probconj2 AA SI algoritmos no 0)
(probconj2 AA SI graficos si 0)
(probconj2 AA SI graficos no 0)
(probconj2 MH SI estudia si 0)
(probconj2 MH SI estudia no 0)
(probconj2 MH SI programar si 0)
(probconj2 MH SI programar no 0)
(probconj2 MH SI ejercicios si 0)
(probconj2 MH SI ejercicios no 0)
(probconj2 MH SI base_datos si 0)
(probconj2 MH SI base_datos no 0)
(probconj2 MH SI redes si 0)
(probconj2 MH SI redes no 0)
(probconj2 MH SI complejidad si 0)
(probconj2 MH SI complejidad no 0)
(probconj2 MH SI conocimiento si 0)
(probconj2 MH SI conocimiento no 0)
(probconj2 MH SI algoritmos si 0)
(probconj2 MH SI algoritmos no 0)
(probconj2 MH SI graficos si 0)
(probconj2 MH SI graficos no 0)
(probconj2 TSI SI estudia si 0)
(probconj2 TSI SI estudia no 0)
(probconj2 TSI SI programar si 0)
(probconj2 TSI SI programar no 0)
(probconj2 TSI SI ejercicios si 0)
(probconj2 TSI SI ejercicios no 0)
(probconj2 TSI SI base_datos si 0)
(probconj2 TSI SI base_datos no 0)
(probconj2 TSI SI redes si 0)
(probconj2 TSI SI redes no 0)
(probconj2 TSI SI complejidad si 0)
(probconj2 TSI SI complejidad no 0)
(probconj2 TSI SI conocimiento si 0)
(probconj2 TSI SI conocimiento no 0)
(probconj2 TSI SI algoritmos si 0)
(probconj2 TSI SI algoritmos no 0)
(probconj2 TSI SI graficos si 0)
(probconj2 TSI SI graficos no 0)
(probconj2 IG SI estudia si 0)
(probconj2 IG SI estudia no 0)
(probconj2 IG SI programar si 0)
(probconj2 IG SI programar no 0)
(probconj2 IG SI ejercicios si 0)
(probconj2 IG SI ejercicios no 0)
(probconj2 IG SI base_datos si 0)
(probconj2 IG SI base_datos no 0)
(probconj2 IG SI redes si 0)
(probconj2 IG SI redes no 0)
(probconj2 IG SI complejidad si 0)
(probconj2 IG SI complejidad no 0)
(probconj2 IG SI conocimiento si 0)
(probconj2 IG SI conocimiento no 0)
(probconj2 IG SI algoritmos si 0)
(probconj2 IG SI algoritmos no 0)
(probconj2 IG SI graficos si 0)
(probconj2 IG SI graficos no 0)
)

(defrule inicio
=>
;;(printout t "Este es un sistema para decidir entre un par de asignaturas de la UGR " crlf)
;; (assert (informar datos))
;;(printout t crlf "DATOS: Los datos estadísticos de que dispongo son:" crlf)
)

;;;; MODULO INFORMAR DATOS ;;;;

(defrule mostrar_prob_simples
(declare (salience 10))
(informar datos)
(influye ?i ?X)
(prob ?i ?v  ?p)
=>
;(printout t "Probabilidad de " ?i "=" ?v " es " ?p crlf)
)

(defrule mostrar_prob_condicionales
(declare (salience 9))
(informar datos)
(efecto ?e ?X)
(probcond ?e ?v ?X SI ?p)
=>
;(printout t "Probabilidad de " ?e "=" ?v " si " ?X " es " ?p crlf)
)

(defrule mostrar_prob_condicionales_bis
(declare (salience 9))
(informar datos)
(efecto ?e ?X)
(probcond ?e ?v ?X NO ?p)
=>
;(printout t "Probabilidad de " ?e "=" ?v " si no " ?X " es " ?p crlf)
)

(defrule mostrar_prob_condicionales2
(declare (salience 8))
(informar datos)
(probcond2 ?X SI ?i1 ?v1 ?i2 ?v2 ?p)
=>
;(printout t "Probabilidad de " ?X " si " ?i1 "=" ?v1 " y " ?i2 "=" ?v2 " es " ?p crlf)
)

(defrule mostrar_prob_condicionales3
(declare (salience 8))
(informar datos)
(probcond3 ?X SI ?i1 ?v1 ?i2 ?v2 ?i3 ?v3 ?p)
=>
;(printout t "Probabilidad de " ?X " si " ?i1 "=" ?v1 ", " ?i2 "=" ?v2 " y " ?i3 "=" ?v3  " "?p crlf)
)

(defrule mostrar_prob_condicionales4
(declare (salience 8))
(informar datos)
(probcond4 ?X SI ?i1 ?v1 ?i2 ?v2 ?i3 ?v3 ?i4 ?v4 ?p)
=>
;(printout t "Probabilidad de " ?X " si " ?i1 "=" ?v1 ", " ?i2 "=" ?v2 ", " ?i3 "=" ?v3  " y " ?i4 "=" ?v4 " " ?p crlf)
)

(defrule ir_a_deducciones_simples
(informar datos)
=>
(printout t crlf "DEDUCCIONES SIMPLES:" crlf)
(assert (deducciones simples))
)

;;;;;;;  MODULO DEDUCCIONES SIMPLES

(defrule calcula_condicionada_negado
(declare (salience 3))
(deducciones simples)
(todo)
(probcond ?e si ?X ?v ?p)
=>
(assert (probcond ?e no ?X ?v (- 1 ?p)))
)

(defrule probconj2
(declare (salience 2))
(deducciones simples)
(probcond ?X SI ?c1 ?v1 ?pc)
(prob ?X SI ?)
(prob ?c1 ?v1 ?p1)
(not (and
        (probcond2 ?X SI ?ca ?va ?cb ?vb ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
     )
)
(not (sumado ?X SI ?c1 ?v1 ) )
(not (valor ?c1 Desconocido))
(todo)
=>
(bind ?p (* ?pc ?p1) )
(assert (sumar probconj2 ?X SI ?c1 ?v1 ?p))
(assert (sumar prob ?X SI ?p))
(assert (sumado ?X SI ?c1 ?v1) )
(printout t "SUMANDO PROBCONJ2 " ?X ?c1 ?v1 crlf)
)

(defrule probconj3
(declare (salience 2))
(deducciones simples)
(probcond2 ?X SI ?c1 ?v1 ?c2 ?v2 ?pc)
(prob ?X SI ?)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(not (and
        (probcond3 ?X SI ?ca ?va ?cb ?vb ?cc ?vc ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
        (valor ?cc ?vc)
     )
)
(not (sumado ?X SI ?c1 ?v1 ?c2 ?v2) )
(not (valor ?c1 Desconocido))
(not (valor ?c2 Desconocido))
(todo)
=>
(bind ?p (* (* ?pc ?p1) ?p2))
(assert (probconj3 ?X SI ?c1 ?v1 ?c2 ?v2 ?p))
(assert (sumar probconj2 ?X SI ?c1 ?v1 ?p))
(assert (sumar probconj2 ?X SI ?c2 ?v2 ?p))
(assert (sumar prob ?X SI ?p))
(assert (sumado ?X SI ?c1 ?v1 ?c2 ?v2) )
; (printout t "SUMANDO PROBCONJ3 " ?X ?c1 ?v1 ?c2 ?v2 crlf)
)

(defrule probconj4
(declare (salience 2))
(deducciones simples)
(probcond3 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?pc)
(prob ?X SI ?)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(prob ?c3 ?v3 ?p3)
(not (and
        (probcond4 ?X SI ?ca ?va ?cb ?vb ?cc ?vc ?cd ?vd ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
        (valor ?cc ?vc)
        (valor ?cd ?vd)
     )
)
(not (sumado ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3) )
(todo)
(not (valor ?c1 Desconocido))
(not (valor ?c2 Desconocido))
(not (valor ?c3 Desconocido))
=>
(bind ?p (* (* (* ?pc ?p1) ?p2) ?p3) )
(assert (probconj4 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?p))
(assert (sumar probconj2 ?X SI ?c1 ?v1 ?p))
(assert (sumar probconj2 ?X SI ?c2 ?v2 ?p))
(assert (sumar probconj2 ?X SI ?c3 ?v3 ?p))
(assert (sumar prob ?X SI ?p))
(assert (sumado ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3) )
; (printout t "SUMANDO PROBCONJ4 " ?X ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 crlf)
)

(defrule probconj5
(declare (salience 2))
(deducciones simples)
(probcond4 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4 ?pc)
(prob ?X SI ?)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(prob ?c3 ?v3 ?p3)
(prob ?c4 ?v4 ?p4)
(todo)
(not (sumado ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4) )
(not (valor ?c1 Desconocido))
(not (valor ?c2 Desconocido))
(not (valor ?c3 Desconocido))
(not (valor ?c4 Desconocido))
=>
(bind ?p (* (* (* (* ?pc ?p1) ?p2) ?p3) ?p4))
(assert (probconj5 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4 ?p))
(assert (sumar probconj2 ?X SI ?c1 ?v1 ?p))
(assert (sumar probconj2 ?X SI ?c2 ?v2 ?p))
(assert (sumar probconj2 ?X SI ?c3 ?v3 ?p))
(assert (sumar probconj2 ?X SI ?c4 ?v4 ?p))
(assert (sumar prob ?X SI ?p))
(assert (sumado ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4) )
; (printout t "SUMANDO PROBCONJ5 " ?X ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4 crlf)
)

(defrule probconj2
(declare (salience 3))
(deducciones simples)
(prob ?X SI ?)
?f <- (probconj2 ?X SI ?c ?v ?p)
?g <- (sumar probconj2 ?X SI ?c ?v ?p1)
(todo)
=>
(assert (probconj2 ?X SI ?c ?v (+ ?p ?p1)))
(retract ?f ?g)
)

(defrule calculado
(declare (salience 9999))
(deducciones simples)
(not (sumar probconj2 ?X SI ?c ?v ?p1))
=>
(assert (calculado))
)

(defrule calcula_probabilidad_condicionada
(declare (salience 1))
(deducciones simples)
(probconj2 ?X SI ?c ?v ?p)
(prob ?c ?v ?pc)
(prob ?X SI ?)
(todo)
=>
(assert (probcond ?X SI ?c ?v (/ ?p ?pc)))
)


(defrule calcula_probabilidad
(declare (salience 2))
(deducciones simples)
?f <- (prob ?X SI ?p)
?g <- (sumar prob ?X SI ?pc)
(todo)
=>
(retract ?f ?g)
(assert (prob ?X SI (+ ?p ?pc)) )
)


(defrule mostrar_prob_condicionales_tris
(deducciones simples)
(probcond ?X SI ?i ?v ?p)
(todo)
=>
;;(printout t "Probabilidad de " ?X " si " ?i "=" ?v " es " ?p crlf)
)

(defrule Informa_probabilidad_a_priori
(declare (salience -1))
(deducciones simples)
(prob ?X SI ?p)
(todo)
=>
(printout t "--> Segun los datos estadisticos: " crlf)
(printout t "A PRIORI: la probabilidad de " ?X " es: " ?p crlf)
(printout t crlf)
)

(defrule ir_a_red_causal_causas
(declare (salience -2))
(prob ?x SI ?p)
(prob ?y SI ?q)
; (not (test (= ?p ?q)  ) )
?f <- (deducciones simples)
(todo)
=>
(printout t "INDAGANDO: Vamos a indagar en base a esos datos" crlf crlf)
(retract ?f)
(assert (red causal causas))
)

;;;;;; MODULO RED CAUSAL CAUSAS

(defrule inferencia0causas
(red causal causas)
(calculado)
(influye ?c1 ?X)
(influye ?c2 ?X)
(test (neq ?c1 ?c2))
(valor ?c1 Desconocido)
(valor ?c2 Desconocido)
(prob ?X SI ?p)
(not (inferido ?X) )
(prob ?X SI ?)
=>
(assert (prob_posteriori_causas ?X ?p))
(assert (prob_conjunta ?X ?p))
(assert (prob_conjunta_negativo ?X (- 1 ?p)))
(assert (inferido ?X) )
)

(defrule inferencia1causas
(red causal causas)
(calculado)
(influye ?c1 ?X)
(influye ?c2 ?X)
(valor ?c1 ?v1)
(not (test (eq ?v1 Desconocido) ) )
(valor ?c2 Desconocido)
(probcond ?X SI ?c1 ?v1 ?p+x/c)
(prob ?c1 ?v1 ?p)
(not (and
        (probcond2 ?X SI ?ca ?va ?cb ?vb ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
     )
)
(not (inferido ?X) )
(prob ?X SI ?)
=>
(assert (prob_posteriori_causas ?X ?p+x/c))
(assert (prob_conjunta ?X (* ?p ?p+x/c)))
(assert (prob_conjunta_negativo ?X (* ?p (- 1 ?p+x/c))))
(printout t "<--------------------------------------------------------------->" crlf)
(printout t  "--> " ?c1 " influye en la probabilidad de " ?X crlf)
(printout t "--> Como " ?c1 " toma el valor " ?v1 ":" crlf)
(printout t "CON ESOS FACTORES: La probabilidad de " ?X " ha cambiado a " ?p+x/c crlf)
(assert (inferido ?X) )
(printout t crlf)
)

(defrule inferencia2causas
(red causal causas)
(calculado)
(influye ?c1 ?X)
(influye ?c2 ?X)
(test (neq ?c1 ?c2))
(valor ?c1 ?v1)
(valor ?c2 ?v2)
(not (test (eq ?v1 Desconocido) ) )
(not (test (eq ?v2 Desconocido) ) )
(probcond2 ?X SI ?c1 ?v1 ?c2 ?v2 ?p+x/c1c2)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(not (and
        (probcond3 ?X SI ?ca ?va ?cb ?vb ?cc ?vc ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
        (valor ?cc ?vc)
     )
)
(prob ?X SI ?)
(not (inferido ?X) )
=>
(assert (prob_posteriori_causas ?X ?p+x/c1c2))
(assert (prob_conjunta ?X (* ?p2 (* ?p1 ?p+x/c1c2))))
(assert (prob_conjunta_negativo ?X (* ?p2 (* ?p1 (- 1 ?p+x/c1c2)))))
(printout t "<--------------------------------------------------------------->" crlf)
(printout t  "---> " ?c1 " y " ?c2 " influyen la probabilidad de " ?X crlf)
(printout t "---> Como " ?c1 " toma el valor " ?v1 " y " ?c2 " toma el valor " ?v2 ":" crlf)
(printout t "CON ESOS FACTORES: La probabilidad de " ?X " ha cambiado a " ?p+x/c1c2 crlf)
(assert (inferido ?X) )
(printout t crlf)
)

(defrule inferencia3causas
(red causal causas)
(calculado)
(influye ?c1 ?X)
(influye ?c2 ?X)
(influye ?c3 ?X)
(test (neq ?c1 ?c2))
(test (neq ?c2 ?c3))
(test (neq ?c1 ?c3))
(valor ?c1 ?v1)
(valor ?c2 ?v2)
(valor ?c3 ?v3)
(not (test (eq ?v1 Desconocido) ) )
(not (test (eq ?v2 Desconocido) ) )
(not (test (eq ?v3 Desconocido) ) )
(probcond3 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?p+x/c1c2c3)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(prob ?c3 ?v3 ?p3)
(not (and
        (probcond3 ?X SI ?ca ?va ?cb ?vb ?cc ?vc ?cd ?vd ?pr)
        (valor ?ca ?va)
        (valor ?cb ?vb)
        (valor ?cc ?vc)
        (valor ?cd ?vd)
     )
)
(not (inferido ?X) )
(prob ?X SI ?)
=>
(assert (prob_posteriori_causas ?X  ?p+x/c1c2c3))
(assert (prob_conjunta ?X (* ?p3 (* ?p2 (* ?p1 ?p+x/c1c2c3)))) )
(assert (prob_conjunta_negativo ?X (* ?p3 (* ?p2 (* ?p1 (- 1 ?p+x/c1c2c3))))))
(printout t "<--------------------------------------------------------------->" crlf)
(printout t  "---> " ?c1 ", " ?c2 " y " ?c3 " influyen la probabilidad de " ?X crlf)
(printout t "---> Como " ?c1 " toma el valor " ?v1 ", " ?c2 " toma el valor " ?v2 " y " ?c3 " toma el valor " ?v3 ":" crlf)
(printout t "CON ESOS FACTORES: La probabilidad de " ?X " ha cambiado a " ?p+x/c1c2c3 crlf)
(assert (inferido ?X) )
(printout t crlf)
)

(defrule inferencia4causas
(red causal causas)
(calculado)
(influye ?c1 ?X)
(influye ?c2 ?X)
(influye ?c3 ?X)
(influye ?c4 ?X)
(test (neq ?c1 ?c2))
(test (neq ?c2 ?c3))
(test (neq ?c1 ?c3))
(test (neq ?c1 ?c4))
(test (neq ?c2 ?c4))
(test (neq ?c3 ?c4))
(valor ?c1 ?v1)
(valor ?c2 ?v2)
(valor ?c3 ?v3)
(valor ?c4 ?v4)
(not (test (eq ?v1 Desconocido) ) )
(not (test (eq ?v2 Desconocido) ) )
(not (test (eq ?v3 Desconocido) ) )
(not (test (eq ?v4 Desconocido) ) )
(probcond4 ?X SI ?c1 ?v1 ?c2 ?v2 ?c3 ?v3 ?c4 ?v4 ?p+x/c1c2c3c4)
(prob ?c1 ?v1 ?p1)
(prob ?c2 ?v2 ?p2)
(prob ?c3 ?v3 ?p3)
(prob ?c4 ?v4 ?p4)
(not (inferido ?X) )
(prob ?X SI ?)
=>
(assert (prob_posteriori_causas ?X ?p+x/c1c2c3c4))
(assert (prob_conjunta ?X (* ?p4 (* ?p3 (* ?p2 (* ?p1 ?p+x/c1c2c3c4)))) ))
(assert (prob_conjunta_negativo ?X (* ?p4 (* ?p3 (* ?p2 (* ?p1 (- 1 ?p+x/c1c2c3c4)))))) )
(printout t "<--------------------------------------------------------------->" crlf)
(printout t  "---> " ?c1 ", " ?c2 ", " ?c3 " y " ?c4 " influyen la probabilidad de " ?X crlf)
(printout t "---> Como " ?c1 " toma el valor " ?v1 ", " ?c2 " toma el valor " ?v2 ", " ?c3 " toma el valor " ?v3
" y " ?c4 " toma el valor " ?v4 ":" crlf)
(printout t "CON ESOS FACTORES: La probabilidad de " ?X " ha cambiado a " ?p+x/c1c2c3c4 crlf)
(printout t crlf)
(assert (inferido ?X) )
)

(defrule ir_a_red_causal_efectos
(declare (salience -1))
(calculado)
(prob_posteriori_causas ?x  ?p)
(prob_posteriori_causas ?y  ?q)
(not (test (eq ?y ?x) ) )
?f <- (red causal causas)
=>
(printout t "BUSCANDO INDICIOS" crlf)
(retract ?f)
(assert (red causal efectos))
)

;;;;; MODULO RED CAUSAL EFECTOS

(defrule redcausal1efecto
(red causal efectos)
(efecto ?e ?X)
(valor ?e ?v & ~Desconocido)
(probcond ?e ?v ?X SI ?pe/+x)
(probcond ?e ?v ?X NO ?pe/-x)
=>
(assert (multiplicar prob_conjunta ?pe/+x))
(assert (multiplicar prob_conjunta_negativo ?pe/-x))
(printout t "--> " ?e " es un efecto de " ?X ". Como " ?e " toma el valor " ?v ":" crlf)
(printout t "--> vamos a utilizarlo para actualizar la probabilidad de " ?X crlf)
(printout t crlf)
)

(defrule actualizar_prob_conjunta
(red causal efectos)
?f <- (prob_conjunta ?X ?p+x)
?g <- (multiplicar prob_conjunta ?pe/+x)
=>
(bind ?p+x+e (* ?pe/+x ?p+x))
(assert (prob_conjunta ?X ?p+x+e))
(retract ?f ?g)
)

(defrule actualizar_prob_conjunta_negativa
(red causal efectos)
?f <- (prob_conjunta_negativo ?X ?p)
?g <- (multiplicar prob_conjunta_negativo ?pe)
=>
(assert (prob_conjunta_negativo ?X (* ?p ?pe)))
(retract ?f ?g)
)

(defrule prob_posteriori
(declare (salience -1))
(red causal efectos)
(prob_conjunta ?X ?p+x)
(prob_conjunta_negativo ?X ?p-x)
=>
(bind ?pc (+ ?p+x ?p-x))
(bind ?p (/ ?p+x ?pc))
(assert (prob_posteriori ?X ?p))
(printout t "FINALMENTE: Por el teorema de bayes a probabilidad de " ?X " ha cambiado a " ?p crlf)
;;(printout t crlf)
)

(deffacts inicio
    (max_posteriori NOLOSE 0)
)

(defrule getMax
    (declare (salience -100))
    (red causal efectos)
    ?f <- (max_posteriori ?X ?p)
    (prob_posteriori ?Y ?q)
    (not (maxE ?Y ?a))
    (test (>= ?q ?p) )
    =>
    (retract ?f)
    (assert (maxE ?Y ?q) )
    (assert (max_posteriori ?Y ?q) )
)
(defrule getMax2
    (declare (salience -100))
    (red causal efectos)
    ?f <- (max_posteriori ?X ?p)
    (prob_posteriori ?Y ?q)
    ?g <- (maxE ?Y ?a)
    (test (> ?q ?p) )
    =>
    (retract ?f ?g)
    (assert (maxE ?Y ?q) )
    (assert (max_posteriori ?Y ?q) )
)

(defrule printWhy
    (declare (salience -100))
    (red causal efectos)
    (max_posteriori ?X ?p)
    (maxE ?X ?q)
    (test (= ?q ?p) )
    =>
    (if (eq ?p 0 ) then (bind ?p 0.5) )
    (printout t "##############################################" crlf)
    (printout t "LA DECISIÓN es: " ?X " con una probabilidad del " (* ?p 100) "%" crlf)
    (printout t "##############################################" crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;   PARA PROBARLO  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Normalmente los valores de las variables que influyen se deducen a partir
;;;  de datos a mas bajo nivel (por ejemplo a partir del pais se deduce la zona
;;;  de riesgo, o a traves del grupo sangíneo se deduce la inmunidad
;;;  Los síntomas o efectos a veces se deducen y otras veces son introducidos por
;;;  el usuario
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass Datos (is-a USER)
    (multislot lista
        (type STRING)
        (create-accessor read-write)
    )
)
;;;; #####################################################################
;;;; #####################################################################
;; Esta función nos permite verificar que el usuario introduce valores
;; que corresponden a las posibles respuestas o valores-permitidos.
;; No es case-sensitive pero devuelve la respuesta en mayuscula
(deffunction pregunta (?pregunta $?valores-permitidos)
    (progn$  (?var ?valores-permitidos) (upcase ?var) )
    (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos) )
    (bind ?respuesta (read))
    (if (not (lexemep ?respuesta) ) then (bind ?respuesta (str-cat ?respuesta "-A") ) )
    (while (not (member$ (upcase ?respuesta) ?valores-permitidos)) do
        (printout t "Perdón, no sé si te entendí bien ¿Puedes repetir?"crlf)
        (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos))
        (bind ?respuesta (read))
    (if (not (lexemep ?respuesta) ) then (bind ?respuesta (str-cat ?respuesta "-A") ) )
    )
    (bind ?respuesta (lowcase ?respuesta) )
)
;; Esta función nos permite verificar que el usuario introduce un número
;; compreendido dentro de un rango definido
(deffunction pregunta-numerica (?pregunta ?rangini ?rangfi)
    (format t "%s [%d, %d]: " ?pregunta ?rangini ?rangfi )
    (bind ?respuesta (read))
    (if (lexemep ?respuesta) then (bind ?respuesta -99999.99999) )
    (while (not (and (>= ?respuesta ?rangini) (<= ?respuesta ?rangfi) ) ) do
        (printout t "Creo que te has salido del rango, prueba otra vez"crlf)
        (format t "%s [%d, %d]: " ?pregunta ?rangini ?rangfi )
        (bind ?respuesta (read))
    (if (lexemep ?respuesta) then (bind ?respuesta -99999.99999) )
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

(deffunction borrar_valor (?user ?valor)
    (bind ?respuesta (send ?user get-lista))
    (bind ?i1 (encontrar_index ?valor ?respuesta) )
    (if (not (eq ?i1 nil) ) then
        (slot-delete$ ?user lista ?i1 ?i1  )
    )
    (bind ?respuesta (send ?user get-lista))
    ?respuesta
)
;;;; #####################################################################
;;;; ######################EXPORTED FROM ACONSEJADOR#####################
;;;; #####################################################################


(deffunction imprimir_todos (?array)
    (bind ?i 1)
    (while (<= ?i (- (length$ ?array) 1)  )
    do
        (bind ?rama (nth$ ?i ?array) )
        (printout t ?rama ", ")
        (bind ?i (+ ?i 1) )
    )
    (bind ?rama (nth$ (length$ ?array)  ?array) )
    (printout t ?rama )
)


(defrule init
(not (prob_posteriori ? ?)  )
(not (object (is-a USER)(lista $?array)))
(not (todo) )
=>
(make-instance datos of Datos (lista IG DDSI ISE MC FR MAC MH IC AA TSI))
)

(defrule preguntar_asignaturas
(not (red causal causas) )
(not (prob_posteriori ? ?)  )
?user <- (object (is-a USER)(lista $?array))
(not (preguntado) )
(not (todo) )
=>
(bind ?respuesta (pregunta "¿Qué primera asignatura te hace dudar? " $?array ))
(bind ?respuesta (upcase ?respuesta) )
(assert (prob ?respuesta SI 0 ) )
(borrar_valor ?user ?respuesta)
(bind ?array (send ?user get-lista))
(bind ?respuesta (pregunta "¿Cuál es la otra asignatura te hace dudar? " $?array ))
(bind ?respuesta (upcase ?respuesta) )
(assert (prob ?respuesta SI 0 ) )
(assert (preguntado) )
)

(defrule check_existence  ;; SANITY CHECK
    (preguntado)
    (not (red causal causas) )
    (not (prob_posteriori ? ?)  )
    ?f <- (prob ?X SI ? )
    ?g <- (prob ?Y SI ? )
    (and(not (probcond2 ?X $?) )
        (not (probcond3 ?X $?) )
        (not (probcond4 ?X $?) )
        (not (probcond2 ?Y $?) )
        (not (probcond3 ?Y $?) )
        (not (probcond4 ?Y $?) )
    )
    (not (test (eq ?X ?Y) ) )
    (not (todo) )
    =>
    (retract ?f ?g)
    (printout t "Lo siento pero no tengo una de las asginaturas en mi base de conocimiento
así que no podré ayudarte a elegir entre ellas... " crlf)
)


(defrule preguntar_teoria
(declare (salience 2 ) )
(not (prob_posteriori ? ?)  )
(not (teoria ? ) )
(preguntado)
(not (todo) )
=>
(bind ?respuesta (pregunta-numerica "Empezemos por lo básico, ¿Cuánto te gusta teoría?" 1 5) )
(assert (teoria ?respuesta) )
)

(defrule preguntar_nota
(declare (salience 2 ) )
(not (prob_posteriori ? ?)  )
(not (nota ?) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta-numerica "Por curiosidad, ¿cuál es tu nota media?" 0 10) )
(assert (nota ?respuesta) )
)

(defrule preguntar_trabajador
(declare (salience 2 ) )
(not (prob_posteriori ? ?)  )
(not (trabajador ? ) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta-numerica "Y te consideras trabajador?" 1 5) )
(assert (trabajador ?respuesta) )
)

(defrule estudia_SI
(not (prob_posteriori ? ?)  )
(teoria ?a)
(nota ?b)
(trabajador ?c)
(test (>= (+ ?a (+ ?b ?c) ) 13) )
(not(valor estudia ?) )
(not (todo) )
(preguntado)
=>
(assert (valor estudia si) )
)

(defrule estudia_NO
(not (prob_posteriori ? ?)  )
(teoria ?a)
(nota ?b)
(trabajador ?c)
(test (< (+ ?a (+ ?b ?c) ) 13) )
(not(valor estudia ?) )
(not (todo) )
(preguntado)
=>
(assert (valor estudia no) )
)

(defrule practicas
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(not (preguntado_practicas) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Otra idea básica es preguntar si te gustan las prácticas, asi que,
¿Te gustan las clases prácticas?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (sobre practicas ?respuesta) )
    else (printout t "Que mentiroso de verdad..." crlf)
         (assert (valor programar Desconocido) )
         (assert (valor ejercicios Desconocido) )
)
(assert (preguntado_practicas) )
)

(defrule programar_o_ejercicios
    (not (prob_posteriori ? ?)  )
    (prob ?X SI ?)
    (sobre practicas ?a)
    (not (test (eq ?a NOLOSE) ) )
    (not (preguntado_programar) )
(not (todo) )
(preguntado)
    =>
    (bind ?respuesta (pregunta "¿pero las prácticas de programar, ejercicios o ambas? "
    (create$ PROGRAMAR EJERCICIOS AMBAS)))
    (if (eq ?respuesta ejercicios) then (assert (valor ejercicios si ) ) (assert (valor programar no) ) )
    (if (eq ?respuesta programar ) then (assert (valor programar  si ) ) (assert (valor ejercicios no) ) )
    (if (eq ?respuesta ambas) then (assert (valor programar si) ) (assert (valor ejercicios si ) ) )
    (assert (preguntado_programar) )
)

(defrule member_of_data
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ DDSI) ) )
(not (preguntado_base_datos) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Una de las asignturas tiene que ver con bases de datos,
¿Te gustan las bases de datos?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor base_datos ?respuesta) )
    else (printout t "Huhm...no me ayudas eh.." crlf)
         (assert (valor redes Desconocido) )
)
(assert (preguntado_base_datos) )
)

(defrule member_of_net
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ ISE FR) ) )
(not (preguntado_redes) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Has elegido una que enseña sobre las conexiones de redes,
¿Te gusta la idea de estudiar sobre el internet?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor redes ?respuesta) )
    else (printout t "¿Enserio? Bueno siguiente" crlf)
         (assert (valor redes Desconocido) )
)
(assert (preguntado_redes) )
)

(defrule member_of_complexity
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ MC MAC) ) )
(not (preguntado_complejidad) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Uff, una es muy teórica, estudia la complejidad de los problemas,
¿Quieres analizar distintos problemas y saber si son computables?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor complejidad ?respuesta) )
    else (printout t "Enfim..." crlf) (assert (valor complejidad Desconocido) )
)
(assert (preguntado_complejidad) )
)

(defrule member_of_knowledge
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ IC AA) ) )
(not (preguntado_conocimiento) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Una de ellas es muy chula, te enseña sobre el conocimiento,
¿Te interesa saber sobre la representación del conocimiento y sus límites?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor conocimiento ?respuesta) )
    else (assert (valor conocimiento Desconocido) )
)
(if (not (eq ?respuesta si) ) then (printout t "¿¿¿CÓMO QUE NO??? Es que ..." crlf) )
(assert (preguntado_conocimiento) )
)

(defrule member_of_algorithms
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ MH TSI) ) )
(not (preguntado_algoritmos) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Una de ellas es sobre programación pura,
¿Te gustaría analizar, comparar e implementar diferentes algoritmos?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor algoritmos ?respuesta) )
    else (printout t "Jooe! Es divertido, yo he hecho un algoritmo basado en ballenas..." crlf)
        (assert (valor algoritmos Desconocido) )
)
(assert (preguntado_algoritmos) )
)

(defrule member_of_graphics
(not (prob_posteriori ? ?)  )
(prob ?X SI ?)
(test (member$ ?X (create$ IG) ) )
(not (preguntado_graficos) )
(not (todo) )
(preguntado)
=>
(bind ?respuesta (pregunta "Una de esas es de diseño gráfico,
¿Te gusta el tema de videojuegos y animación?" (create$ SI NO NOLOSE)))
(if (not (eq ?respuesta nolose ) ) then (assert (valor graficos ?respuesta) )
    else (printout t "Te pasas..." crlf) (assert (valor graficos Desconocido) ) )
(assert (preguntado_graficos) )
)

(defrule ultima
    (declare (salience -9999))
    (prob ?X SI ?)
    (preguntado)
    (not (todo) )
    =>
    (printout t "########################" crlf)
    (printout t "Iré a calcular las probabilidades a priori con la información dada" crlf)
    (printout t "########################"crlf)
    (assert (todo) )
    (assert (informar datos) )
)



