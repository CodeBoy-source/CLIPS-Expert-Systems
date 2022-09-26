;;;; Copyright Brian Sena Simons
(defrule initialize
(declare (salience 9998))
    =>
    (printout t "Bienvenido los factores de Certeza de Brian Sena" crlf)
    (printout t "Intentaremos encontrar el problema de su coche con un par de preguntas" crlf)
)

(deffacts cosas
    (maxH desconocido 0)
    (maxE desconocido 0 "Porque desconozco")
)
;; (FactorCerteza ?h si|no ?f) representa que ?h se ha deducido con factor ?f
;; ?h podrá_ser
;    - problema_starter
;    - problema_bujias
;    - problema_bateria
;    - motor_llega_gasolina
;; (Evidencia ?e si|no) representa el hecho de si evidencia ?e se da
;; ?e podrá ser:
;    - hace_intentos_arrancar
;    - hay_gasolina_en_deposito
;    - encienden_las_luces
;    - gira_motor
;;; convertimos cada evidencia en una afirmación sobre su factor de certeza
(defrule certeza_evidencias
    (Evidencia ?e ?r)
    =>
    (assert (FactorCerteza ?e ?r 1) )
)
;; También podríamos considerar evidencias con uan cierta
;; Incertidumbre: al preguntar por la evidencia, pedir y recoger directamente.

(deffunction encadenado (?fc_antecedente ?fc_regla)
    (if (> ?fc_antecedente 0)
        then
            (bind ?rv (* ?fc_antecedente ?fc_regla ) )
        else
            (bind ?rv 0)
    )
    ?rv
)

(deffunction combinacion (?fc1 ?fc2)
    (if (and (> ?fc1 0) (> ?fc2 0 ) )
        then
            (bind ?rv (- (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
        else
            (if (and (< ?fc1 0) (< ?fc2 0) )
                then
                    (bind ?rv (+ (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
                else
                    (bind ?rv (/ (+ ?fc1 ?fc2) (- 1 (min (abs ?fc1) (abs ?fc2) ) ) ) )
            )
    )
    ?rv
)

(deffunction pregunta (?pregunta $?valores-permitidos)
    (progn$  (?var ?valores-permitidos) (upcase ?var) )
    (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos) )
    (bind ?respuesta (read))
    (while (not (member$ (upcase ?respuesta) ?valores-permitidos)) do
        (format t "%s (%s): " ?pregunta (implode$ ?valores-permitidos))
        (bind ?respuesta (read))
    )
    (bind ?respuesta (lowcase ?respuesta) )
)

;; R1: Si el motor obtiene gasolina Y el motor gira entonces problemas
; con las bujías con certeza 0.7
(defrule R1
    (declare (salience -100))
    (not (R1))
    (FactorCerteza motor_llega_gasolina si ?f1)
    (FactorCerteza gira_motor si ?f2)
    (test (and (> ?f1 0) (> ?f2 0)))
    =>
    (assert (FactorCerteza problema_bujias si (encadenado (* ?f1 ?f2) 0.7)))
    (assert (Explicacion problema_bujias (encadenado (* ?f1 ?f2) 0.7)
    "porque al motor si llega gasolina y además hace intentos de girar" ) )
    (assert (R1))
)


(defrule R2
    (declare (salience -100))
    (not (R2) )
    (FactorCerteza gira_motor no ?f1)
    (test (> ?f1 0) )
    =>
    (assert (FactorCerteza problema_starter si (encadenado ?f1 0.8)) )
    (assert (Explicacion problema_starter (encadenado ?f1 0.8) "dado que el motor no gira") )
    (assert (R2))
)

(defrule R3
    (declare (salience -100))
    (not (R3))
    (FactorCerteza encienden_las_luces no ?f1)
    (test (> ?f1 0))
    =>
    (assert (FactorCerteza problema_bateria si (encadenado ?f1 0.8)) )
    (assert (Explicacion problema_bateria (encadenado ?f1 0.8) "dado que las luces no encienden") )
    (assert (R3) )
)

(defrule R4
    (declare (salience -100))
    (not (R4) )
    (FactorCerteza hay_gasolina_en_deposito si ?f1)
    (test (> ?f1 0 ) )
    =>
    (assert (FactorCerteza motor_llega_gasolina si (encadenado ?f1 0.9)))
    (assert (R4) )
)

(defrule R5-6
    (declare (salience -100))
    (not (R5) )
    (FactorCerteza hace_intentos_arrancar si ?f1)
    (test (> ?f1 0) )
    =>
    (assert (FactorCerteza problema_starter si (encadenado ?f1 -0.6) ) )
    (assert (Explicacion problema_starter (encadenado ?f1 -0.6) "porque hemos visto que hace intentos de arrancar") )
    (assert (FactorCerteza problema_bateria si (encadenado ?f1 0.5) ) )
    (assert (Explicacion problema_bateria (encadenado ?f1 0.5) "porque hemos visto que hace intentos de arrancar") )
    (assert (R5) )
)

(defrule preguntar_motor
    (declare (salience 5))
    (not (Evidencia gira_motor ?) )
    =>
    (bind ?respuesta (pregunta "Empezemos, el motor del coche gira? (si no)"
    (create$ SI NO) ))
    (assert (Evidencia gira_motor ?respuesta) )
)

(defrule preguntar_luces
    (declare(salience 5))
    (not (Evidencia encienden_las_luces ?) )
    =>
    (bind ?respuesta (pregunta "Interesante, y las luces hacen algo? Se encienden? (si no)"
    (create$ SI NO) ))
    (assert (Evidencia encienden_las_luces ?respuesta) )
)

(defrule preguntar_gasolina
    (declare(salience 5))
    (not (Evidencia hay_gasolina_en_deposito ?) )
    =>
    (bind ?respuesta (pregunta "Aish, se me olvidaba lo básico, tiene gasolina? (si no)"
    (create$ SI NO) ))
    (assert (Evidencia hay_gasolina_en_deposito ?respuesta) )
)
(defrule preguntar_arrancar
    (declare(salience 5))
    (not (Evidencia hace_intentos_arrancar ?) )
    =>
    (bind ?respuesta (pregunta "Entiendo claro, y hace intentos de arrancar?(si no)"
    (create$ SI NO) ))
    (assert (Evidencia hace_intentos_arrancar ?respuesta) )
)


(defrule combinar
    (declare (salience 1))
    ?f <- (FactorCerteza ?h ?r ?fc1)
    ?g <- (FactorCerteza ?h ?r ?fc2)
    (test (neq ?fc1 ?fc2) )
    =>
    (retract ?f ?g)
    (assert (FactorCerteza ?h ?r (combinacion ?fc1 ?fc2) ) )
)

(defrule combinar_signo
    (declare (salience 2) )
    (FactorCerteza ?h si ?fc1)
    (FactorCerteza ?h no ?fc2)
    =>
    (assert (Certeza ?h (- ?fc1 ?fc2) ) )
)


(defrule hipotesis1
    ?f <- (FactorCerteza problema_bujias si ?f1)
    ?e <- (Explicacion problema_bujias ?f1 ?text)
    ?g <- (maxH ?h ?x2)
    ?i <- (maxE ?h ? ?)
    (test (> ?f1 ?x2) )
    =>
    (retract ?f ?g ?i)
    (assert (maxH problema_bujias ?f1) )
    (assert (maxE problema_bujias ?f1 ?text) )
)

(defrule hipotesis2
    ?f <- (FactorCerteza problema_starter si ?f1)
    ?e <- (Explicacion problema_starter ?f1 ?text)
    ?g <- (maxH ?h ?x2)
    ?i <- (maxE ?h ? ?)
    (test (> ?f1 ?x2) )
    =>
    (retract ?f ?g ?i)
    (assert (maxH problema_stater ?f1) )
    (assert (maxE problema_starter ?f1 ?text) )
)

(defrule hipotesis3
    ?f <- (FactorCerteza problema_bateria si ?f1)
    ?e <- (Explicacion problema_bateria ?f1 ?text)
    ?g <- (maxH ?h ?x2)
    ?i <- (maxE ?h ? ?)
    (test (> ?f1 ?x2) )
    =>
    (retract ?f ?g ?i)
    (assert (maxH problema_bateria ?f1) )
    (assert (maxE problema_bateria ?f1 ?text) )
)

(defrule imprimision
    (declare (salience -9999))
    ?f <- (maxH ?hip ?x)
    ?g <- (maxE ?hip ?x ?expl)
    (not (test (eq ?hip desconocido) ) )
    =>
    (printout t (str-cat "He deducido que tienes un " ?hip " con un factor
de certeza del " (* ?x 100) " " ?expl ".") crlf )
    (retract ?f ?g)
)
