(deftemplate fiebre
    0 10
    (
        (muy_baja (0 1) (2 1) (4 0))
        (baja (2 0) (4 1) (6 0))
        (media (4 0) (6 1) (8 0))
        (alta (6 0) (8 1) (10 0))
        (muy_alta (8 0) (10 1) (10 1))
    )
)

(deftemplate dolor_bulto
    0 10
    (
        (ninguno (0 1) (2 1) (4 0))
        (ligero (2 0) (4 1) (6 0))
        (moderado (4 0) (6 1) (8 0))
        (severo (6 0) (8 1) (10 0))
        (muy_severo (8 0) (10 1) (10 1))
    )
)

(deftemplate malestar
    0 10
    (
        (muy_bajo (0 1) (2 1) (4 0))
        (bajo (2 0) (4 1) (6 0))
        (medio (4 0) (6 1) (8 0))
        (alto (6 0) (8 1) (10 0))
        (muy_alto (8 0) (10 1) (10 1))
    )
)

(defrule regla_1
    (fiebre muy_baja)
    (dolor_bulto ninguno)
=>
    (assert (malestar muy_alto))
)

(defrule regla_2
    (fiebre muy_baja)
    (dolor_bulto ligero)
=>
    (assert (malestar alto))
)

(defrule regla_3
    (fiebre muy_baja)
    (dolor_bulto moderado)
=>
    (assert (malestar medio))
)

(defrule regla_4
    (fiebre muy_baja)
    (dolor_bulto severo)
=>
    (assert (malestar bajo))
)

(defrule regla_5
    (fiebre muy_baja)
    (dolor_bulto muy_severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_6
    (fiebre baja)
    (dolor_bulto ninguno)
=>
    (assert (malestar alto))
)

(defrule regla_7
    (fiebre baja)
    (dolor_bulto ligero)
=>
    (assert (malestar medio))
)

(defrule regla_8
    (fiebre baja)
    (dolor_bulto moderado)
=>
    (assert (malestar bajo))
)

(defrule regla_9
    (fiebre baja)
    (dolor_bulto severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_10
    (fiebre baja)
    (dolor_bulto muy_severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_11
    (fiebre media)
    (dolor_bulto ninguno)
=>
    (assert (malestar medio))
)

(defrule regla_12
    (fiebre media)
    (dolor_bulto ligero)
=>
    (assert (malestar bajo))
)

(defrule regla_13
    (fiebre media)
    (dolor_bulto moderado)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_14
    (fiebre media)
    (dolor_bulto severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_15
    (fiebre media)
    (dolor_bulto muy_severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_16
    (fiebre alta)
    (dolor_bulto ninguno)
=>
    (assert (malestar bajo))
)

(defrule regla_17
    (fiebre alta)
    (dolor_bulto ligero)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_18
    (fiebre alta)
    (dolor_bulto moderado)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_19
    (fiebre alta)
    (dolor_bulto severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_20
    (fiebre alta)
    (dolor_bulto muy_severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_21
    (fiebre muy_alta)
    (dolor_bulto ninguno)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_22
    (fiebre muy_alta)
    (dolor_bulto ligero)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_23
    (fiebre muy_alta)
    (dolor_bulto moderado)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_24
    (fiebre muy_alta)
    (dolor_bulto severo)
=>
    (assert (malestar muy_bajo))
)

(defrule regla_25
    (fiebre muy_alta)
    (dolor_bulto muy_severo)
=>
    (assert (malestar muy_bajo))
)

