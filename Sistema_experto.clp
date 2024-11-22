(defglobal ?*alta_posibilidad_linfoma* = no)

;Regla que pregunte por el nombre de una persona y lo almacene en una variable

(defrule Leer-Nombre
 (not (nombre_paciente ?))
 =>
 (printout t "Por favor, introduce tu nombre: ")
 (bind ?nombre_paciente (read))
 (assert (nombre_paciente ?nombre_paciente))
)

;Regla para saber la movilidad del bulto y almacenarlo en una variable

(defrule Movilidad-Bulto
 ?nombre_paciente <- (nombre_paciente ?nombre)
 =>
 (printout t "Hola bienvenido a nuestro sistema de detección de linfomas, " ?nombre crlf)
 (printout t "Por favor, responde las siguientes preguntas para determinar si tienes un linfoma o un simple bulto por infección" crlf)
 (printout t crlf)
 (printout t "¿El bulto es movil o fijo? (movil/fijo): ")
 (bind ?movilidad_bulto (read))
 (if (eq ?movilidad_bulto movil)
     then
     (assert (movilidad_movil ?movilidad_bulto))
 else
     (assert (movilidad_fijo ?movilidad_bulto)))
)

;Regla para saber si el bulto es tiene consistencia dura o blanda y almacenarlo en una variable

(defrule Consistencia-Bulto
 ?nombre_paciente <- (nombre_paciente ?nombre)
 (or (movilidad_movil ?)
     (movilidad_fijo ?))
 =>
 (printout t "¿El bulto es duro o blando? (duro/blando): ")
 (bind ?consistencia_bulto (read))
 (if (eq ?consistencia_bulto duro)
     then
     (assert (consistencia_duro ?consistencia_bulto))
 else
     (assert (consistencia_blando ?consistencia_bulto)))
)

;Regla para diagnostico, si el bulto es fijo y duro es posible linfoma, si es movil y blando posible infeción y si es movil y duro o fijo y blando es seguir con estudios

(defrule Diagnostico-1
 (nombre_paciente ?nombre)
 (or (movilidad_movil ?movilidad)
     (movilidad_fijo ?movilidad))
 (or (consistencia_duro ?consistencia)
     (consistencia_blando ?consistencia))
 =>
 (if (and (eq ?movilidad movil) (eq ?consistencia blando))
     then
     (printout t "Tienes sintomas de un posible bulto por infección, hagamos más preguntas para confirmar" crlf)
     (assert (posible_infeccion si))  
     (printout t crlf)
 else
     (if (and (eq ?movilidad fijo) (eq ?consistencia duro))
         then
         (printout t "Tienes sintomas de un posible linfoma, hagamos más pregunta para confirmar" crlf)
         (assert (posible_linfoma si)) 
         (printout t crlf)
     else
         (printout t "Es pronto para diagnosticar algo ya que presentas caracteristicas tanto de linfoma como de bulto por infección, sigamos preguntando" crlf)
         (assert (seguir_estudiando si)) 
         (printout t crlf)
     )
 )
)

;Sintomas infección o para seguir preguntando------------------------------------------------------------------------------------------------

;En caso de posible infección se pregunta si tiene dolor de cabeza y se almacena en una variable

(defrule Dolor-Cabeza
 (posible_infeccion si)
 =>
 (printout t "¿Tienes dolor de cabeza? (si/no): ")
 (bind ?dolor_cabeza (read))
 (if (eq ?dolor_cabeza si)
     then
     (assert (dolor_cabeza ?dolor_cabeza))
 else
     (assert (no_dolor_cabeza ?dolor_cabeza)))
)

;En caso de posible infección se pregunta si tiene pus 

(defrule Pus
 (or (posible_infeccion si)
     (seguir_estudiando si))
 =>
 (printout t "¿Tienes pus en el bulto? (si/no): ")
 (bind ?pus (read))
 (if (eq ?pus si)
     then
     (assert (si_pus ?pus))
 else
     (assert (no_pus ?pus)))
)

;En caso de posible infección se pregunta si tiene presenta dolor el bulto

(defrule Dolor-Bulto
 (posible_infeccion si)
 =>
 (printout t "¿Tienes dolor en el bulto, de tipo punzante o al apretarlo? (si/no): ")
 (bind ?dolor_bulto (read))
 (if (eq ?dolor_bulto si)
     then
     (assert (si_dolor_bulto ?dolor_bulto))
 else
     (assert (no_dolor_bulto ?dolor_bulto)))
)

;En caso de posible infección se pregunta si tiene dolor al tragar

(defrule Dolor-Tragar
 (posible_infeccion si)
 =>
 (printout t "¿Tienes dolor al tragar? (si/no): ")
 (bind ?dolor_tragar (read))
 (if (eq ?dolor_tragar si)
     then
     (assert (si_dolor_tragar ?dolor_tragar))
 else
     (assert (no_dolor_tragar ?dolor_tragar)))
)


;En caso de posible infección se pregunta si has estado enfermo recientemente

(defrule Enfermo-Recientemente
 (posible_infeccion si)
 =>
 (printout t "¿Has estado enfermo recientemente? (si/no): ")
 (bind ?enfermo_recientemente (read))
 (if (eq ?enfermo_recientemente si)
     then
     (assert (si_enfermo_recientemente ?enfermo_recientemente))
 else
     (assert (no_enfermo_recientemente ?enfermo_recientemente)))
)


;Sintomas Linfoma o para seguir preguntando------------------------------------------------------------------------------------------------

;En caso de posible linfoma se pregunta si ha tenido perdida de persona

(defrule Perdida-Peso
 (posible_linfoma si)
 =>
 (printout t "¿Has tenido pérdida de peso en el ultimo mes? (si/no): ")
 (bind ?perdida_peso (read))
 (if (eq ?perdida_peso si)
     then
     (assert (si_perdida_peso ?perdida_peso))
 else
     (assert (no_perdida_peso ?perdida_peso)))
)

;En caso de posible linfoma se pregunta si ha tenido sudoración nocturna profusa

(defrule Sudoracion-Nocturna
 (or (posible_linfoma si)
     (seguir_estudiando si))

 =>
 (printout t "¿Has tenido sudoración nocturna profusa? (si/no): ")
 (bind ?sudoracion_nocturna (read))
 (if (eq ?sudoracion_nocturna si)
     then
     (assert (si_sudoracion_nocturna ?sudoracion_nocturna))
 else
     (assert (no_sudoracion_nocturna ?sudoracion_nocturna)))
)

;En caso de posible linfoma se pregunta si ha tenido quimio anteriormente

(defrule Quimio
 (or  (posible_linfoma si)
      (seguir_estudiando si))
 
 =>
 (printout t "¿Has tenido quimioterapia anteriormente? (si/no): ")
 (bind ?quimio (read))
 (if (eq ?quimio si)
     then
     (assert (si_quimio ?quimio))
 else
     (assert (no_quimio ?quimio)))
)

;En caso de posible linfoma se pregunta si el bulto presenta prurito(Picor)

(defrule Prurito
 (posible_linfoma si)
 =>
 (printout t "¿El bulto presenta prurito? (si/no): ")
 (bind ?prurito (read))
 (if (eq ?prurito si)
     then
     (assert (si_prurito ?prurito))
 else
     (assert (no_prurito ?prurito)))
)

;En caso de posible linfoma se pregunta si se presenta esplenomegalia

(defrule Esplenomegalia
 (posible_linfoma si)
 =>
 (printout t "¿Tienes esplenomegalia? (si/no): ")
 (bind ?esplenomegalia (read))
 (if (eq ?esplenomegalia si)
     then
     (assert (si_esplenomegalia ?esplenomegalia))
 else
     (assert (no_esplenomegalia ?esplenomegalia)))
)

; En cualquier caso ------------------------------------------------------------------------------------------------

(defrule Fiebre
   (or (posible_infeccion si)
       (posible_linfoma si)
       (seguir_estudiando si))
=>
   (printout t "¿Has tenido fiebre? (si/no): ")
   (bind ?tipo_fiebre (read))
   (if (eq ?tipo_fiebre si)
       then
       (printout t "¿La fiebre ha sido baja o alta? (baja/alta): ")
       (bind ?tipo_fiebre (read))
       (if (eq ?tipo_fiebre baja)
           then
           (assert (si_fiebre_baja ?tipo_fiebre))
           else
           (assert (si_fiebre_alta ?tipo_fiebre)))
       else
       (assert (no_fiebre ?tipo_fiebre)))
)

;Regla para terminar las preguntas

(defrule Terminacion-Preguntas
    (or (posible_infeccion si)
        (posible_linfoma si)
        (seguir_estudiando si))
    =>
    (assert (terminacionpreguntas si))
)


;Una vez recogido los sintomas toca hacer los diagnosticos

(defrule Diagnostico-Infeccion
   (posible_infeccion si)
   (terminacionpreguntas si)
   (or  (dolor_cabeza ?sintoma_dolor_cabeza)
        (no_dolor_cabeza ?sintoma_dolor_cabeza))
   (or  (si_pus ?pus)
        (no_pus ?pus))
   (or  (si_dolor_bulto ?dolor_bulto)
        (no_dolor_bulto ?dolor_bulto))
   (or  (si_dolor_tragar ?dolor_tragar)
        (no_dolor_tragar ?dolor_tragar))
   (or  (si_enfermo_recientemente ?enfermo_recientemente)
        (no_enfermo_recientemente ?enfermo_recientemente))
   (or  (si_fiebre_baja ?tipo_fiebre)
        (si_fiebre_alta ?tipo_fiebre)
        (no_fiebre ?tipo_fiebre))
   =>
   (if (and (eq ?sintoma_dolor_cabeza si) (eq ?pus si) (eq ?dolor_bulto si) (eq ?dolor_tragar si) (eq ?enfermo_recientemente si) (eq ?tipo_fiebre baja))
      then
      (printout t "Tienes una probabilidad de un 100% de tener un bulto por infección, te recomendamos ir a un especialista en infecciones para que te haga una revisión" crlf)
      (assert (diagnostico_infeccion si))
      (assert (posible_infeccion no))
      (printout t crlf)
   else
      (if (eq ?pus si)
          then
          (printout t "Tienes una probabilidad alrededor de un 90% de tener un bulto por infección, te recomendamos ir a un especialista en infecciones para que te haga una revisión" crlf)
          (printout t "Debido a que el porcentaje es igual o superior al 70% no es necesario hacer las pruebas de linfoma" crlf)
      else
         (if (or (eq ?tipo_fiebre baja) (eq ?sintoma_dolor_cabeza si))
                then
                (printout t "Tienes una probabilidad alrededor de un 80% de tener un bulto por infección, te recomendamos ir a un especialista en infecciones para que te haga una revisión" crlf)
                (printout t "Debido a que el porcentaje es igual o superior al 70% no es necesario hacer las pruebas de linfoma" crlf)
         else
            (if (or (eq ?dolor_bulto si) (eq ?dolor_tragar si))
                then
                (printout t "Tienes una probabilidad alrededor de un 70% de tener un bulto por infección, te recomendamos ir a un especialista en infecciones para que te haga una revisión" crlf)
                (printout t "Debido a que el porcentaje es igual o superior al 70% no es necesario hacer las pruebas de linfoma" crlf)
            else
                (if (eq ?enfermo_recientemente si)
                    then
                    (printout t "Tienes una probabilidad alrededor de un 60% de tener un bulto por infección" crlf)
                    (assert (poca_probabilidad_infeccion si))
                else
                    (printout t "Tienes una probabilidad de un 50% de tener un bulto por infección" crlf)
                    (assert (poca_probabilidad_infeccion si))
                    ; Aquí termina este bloque de condición
                )
            )
         )
      )
   )
)


(defrule Preguntar-Si-Seguir-Estudiando
    (poca_probabilidad_infeccion si)
    =>
    (printout t crlf)
    (printout t "Como has visto tienes un probabilidad baja de que sea un bulto por infección ¿Desea hacerse las pruebas del linfoma? (si/no): ")
    (bind ?pruebas (read))
    (if (eq ?pruebas si)
        then
        (assert (seguir_estudiando_linfoma si))
    else
        printout t "Vale, muchas gracias por usar nuestro sistema, le aconsejamos que en caso de notar mas cambios vuelva a realizar la prueba con los nuevos sintomas" crlf)
)

(defrule Diagnostico-Linfoma
   (posible_linfoma si)
   (terminacionpreguntas si)
   (or  (si_perdida_peso ?perdida_peso)
        (no_perdida_peso ?perdida_peso))
   (or  (si_sudoracion_nocturna ?sudoracion_nocturna)
        (no_sudoracion_nocturna ?sudoracion_nocturna))
   (or  (si_quimio ?quimio)
        (no_quimio ?quimio))
   (or  (si_prurito ?prurito)
        (no_prurito ?prurito))
   (or  (si_esplenomegalia ?esplenomegalia)
        (no_esplenomegalia ?esplenomegalia))
   (or  (si_fiebre_baja ?tipo_fiebre)
        (si_fiebre_alta ?tipo_fiebre)
        (no_fiebre ?tipo_fiebre))
    =>
    (if (and (eq ?perdida_peso si) (eq ?sudoracion_nocturna si) (eq ?quimio si) (eq ?prurito si) (eq ?esplenomegalia si) (eq ?tipo_fiebre alta))
        then
        (printout t "Tienes una probabilidad de un 100% de un linfoma" crlf)
        (assert (diagnostico_linfoma si))
        (assert (posible_linfoma no))
        (bind ?*alta_posibilidad_linfoma* si)
        (printout t crlf)
    else
        (if (eq ?quimio si)
            then
            (printout t "Tienes una probabilidad de un 90% de tener un linfoma" crlf)
            (assert (diagnostico_linfoma si))
            (assert (posible_linfoma no))
            (bind ?*alta_posibilidad_linfoma* si)
            (printout t crlf)
        else
            (if (or (eq ?tipo_fiebre alta) (eq ?perdida_peso si))
                then
                (printout t "Tienes una probabilidad de un 80% de tener un linfoma" crlf)
                (assert (diagnostico_linfoma si))
                (assert (posible_linfoma no))
                (bind ?*alta_posibilidad_linfoma* si)
                (printout t crlf)
            else
                (if (or (eq ?sudoracion_nocturna si) (eq ?prurito si) (eq ?esplenomegalia si))
                    then
                    (printout t "Tienes una probabilidad de un 70% de tener un linfoma" crlf)
                    (assert (diagnostico_linfoma si))
                    (assert (posible_linfoma no))
                    (assert (alta_posibilidad_linfoma si))
                    (printout t crlf)
                else
                    (printout t "Tienes una probabilidad de un 50% de de tener un linfoma" crlf)
                    (assert (diagnostico_linfoma si))
                    (assert (posible_linfoma no))
                    (printout t crlf)
                )
            )
        )
    )
    (printout t crlf)
    (printout t "Ya sabemos que se puede tratar de un linfoma, examinemos que tipo es" crlf)
)

(defrule Diagnostico-Seguir-Estudiando
    (seguir_estudiando si)
    (terminacionpreguntas si)
    (or (si_fiebre_baja ?tipo_fiebre)
        (si_fiebre_alta ?tipo_fiebre)
        (no_fiebre ?tipo_fiebre))
    (or (si_pus ?pus)
        (no_pus ?pus))
    (or (si_sudoracion_nocturna ?sudoracion_nocturna)
        (no_sudoracion_nocturna ?sudoracion_nocturna))
    (or (si_quimio ?quimio)
        (no_quimio ?quimio))
    =>
    (if (and (eq ?tipo_fiebre baja) (eq ?pus si))
        then
        (printout t "Tienes una probabilidad de un 80% de tener un bulto por infección" crlf)
        (printout t "Aunque el porcentaje de no ser un linfoma es alto, debido a la consistencia del mismo, realizaremos pruebas para confirmar" crlf)
        (assert (diagnostico_linfoma si))
        (printout t crlf)
    else
        (if (eq ?pus si)
            then
            (printout t "Tienes una probabilidad de un 70% de tener un bulto por infección" crlf)
            (printout t "Aunque el porcentaje de no ser un linfoma es alto, debido a la consistencia del mismo, realizaremos pruebas para confirmar" crlf)
            (assert (diagnostico_linfoma si))
            (printout t crlf)
        else
            (if (eq ?quimio si)
                then
                (printout t "Tienes una probabilidad de un 90% de tener un linfoma, realizaremos las pruebas para ver que tipo es" crlf)
                (assert (diagnostico_linfoma si))
                (bind ?*alta_posibilidad_linfoma* si)
                (printout t crlf)
            else
                (if (eq ?tipo_fiebre alta)
                    then
                    (printout t "Tienes una probabilidad de un 80% de tener un linfoma, realizaremos las pruebas para ver que tipo es" crlf)
                    (assert (diagnostico_linfoma si))
                    (bind ?*alta_posibilidad_linfoma* si)
                    (printout t crlf)
                else
                    (if (eq ?sudoracion_nocturna si)
                        then
                        (printout t "Tienes una probabilidad de un 60% de tener un linfoma, realizaremos las pruebas para confirmar" crlf)
                        (assert (diagnostico_linfoma si))
                        (printout t crlf)
                    else
                        (printout t "Tienes una probabilidad de un 50% de tener un linfoma, realizaremos las pruebas para confirmar" crlf)
                        (assert (diagnostico_linfoma si))
                        (printout t crlf)
                    )
                )
            )
        )
    )
)


(defrule Analizar-linfoma
    (or (linfoma si)
        (diagnostico_linfoma si)
        (seguir_estudiando_linfoma si))
    =>
    (printout t "Para confirmar si tienes un linfoma, haremos una biopsia" crlf)
    (printout t "¿Tras realizar la biopsia hay presencia de células Reed-SternBerg (si/no): ")
    (bind ?celulas (read))
    (if (eq ?celulas si)
        then
        (printout t crlf)
        (printout t "Tienes un linfoma de Hodgkin" crlf)
        (printout t "Analicemos de qué tipo es" crlf)
        (assert (linfoma_hodgkin si))
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma no Hodgkin" crlf)
        (printout t "Analicemos de qué tipo es, para ello, haremos una serie de preguntas" crlf)
        (assert (linfoma_no_hodgkin si))
        (printout t crlf)
    )
)

(defrule Analizar-linfoma-Hodgkin
    (linfoma_hodgkin si)
    =>
    (printout t "Para saber de qué tipo es tu linfoma de Hodgkin, realizaremos un inmunofenotipo" crlf)
    (printout t "¿Tras realizar el inmunofenotipo hay presencia de proteínas CD30+ y CD15+ (si/no): ")
    (bind ?proteinas_hodgkin (read))
    (if (eq ?proteinas_hodgkin si)
        then
        (printout t crlf)
        (printout t "Tienes un linfoma de Hodgkin clásico" crlf)
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma de Hodgkin nodular con predominio linfocítico" crlf)
        (printout t crlf)
    )
)



(defrule Preguntar-proteinas
   (linfoma_no_hodgkin si)
   =>
   (printout t "Tras realizar el inmunofenotipo, ¿qué tipo de proteínas hay?" crlf)
   (printout t "Tipo 1 = CD5- y CD10+" crlf)
   (printout t "Tipo 2 = CD5+ y CD10+" crlf)
   (printout t "Tipo 3 = CD5- y CD10-" crlf)
   (printout t "Tipo 4 = CD5+ y CD10-" crlf)
   (printout t "Tipo 5 = No hay proteínas" crlf)
   (bind ?proteinas_no_hodgkin (read))
   (if (eq ?proteinas_no_hodgkin 1)
      then
      (printout t crlf)
      (printout t "Presencia de un linfoma Folicular" crlf)
      (assert (linfoma_folicular si))
      (printout t "Analicemos si esta avanzado o no" crlf)
      (printout t crlf)
   else
      (if (eq ?proteinas_no_hodgkin 2)
         then
         (printout t crlf)
         (printout t "Presencia de un linfoma difuso de célula grande" crlf)
         (assert (linfoma_difuso si))
         (printout t crlf)
      else
         (if (eq ?proteinas_no_hodgkin 3)
            then
            (printout t crlf)
            (printout t "Presencia de linfoma de la zona marginal" crlf)
            (assert (linfoma_marginal si))
            (printout t crlf)
         else
            (if (eq ?proteinas_no_hodgkin 4)
               then
               (printout t crlf)
               (printout t "Presencia de linfoma célula del manto" crlf)
                (assert (linfoma_manto si))
               (printout t crlf)
            else
               (printout t crlf)
               (printout t "Podrías tener un linfoma de Burkitt" crlf)
               (assert (posible_linfoma_burkitt si))
               (printout t crlf)
            )
         )
      )
   )
)

(defrule Preguntar-Linfoma-Folicular
    (linfoma_folicular si)
    =>
    (printout t "¿Presenta translocación de los cromosomas 14 y 18 (si/no)?" crlf)
    (bind ?translocacion (read))
    (if (eq ?translocacion si)
        then
        (printout t crlf)
        (printout t "Tienes un linfoma folicular avanzado" crlf)
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma folicular no avanzado" crlf)
        (printout t crlf)
    )
)

(defrule Preguntares-Linfoma-Difuso
    (linfoma_difuso si)
    =>
    (printout t "¿Presenta los genes BCL2, BCL6 y MYC (si/no)?" crlf)
    (bind ?genes (read))
    (if (eq ?genes si)
        then
        (printout t crlf)
        (printout t "Tienes un linfoma difuso de célula grande avanzado" crlf)
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma difuso de célula grande no avanzado" crlf)
        (printout t crlf)
    )
)

(defrule Preguntar-Linfoma-Marginal
    (linfoma_marginal si)
    =>
    (printout t "¿Presenta translocacion de los cromosomas 11 y 18 (si/no)?" crlf)
    (bind ?translocacion (read))
    (if (eq ?translocacion si)
        then
        (printout t crlf)
        (printout t "Tienes un linfoma de la zona marginal avanzado" crlf)
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma de la zona marginal no avanzado" crlf)
        (printout t crlf)
    )
)

(defrule Preguntar-Linfoma-Manto
    (linfoma_manto si)
    =>
    (printout t "¿Presenta la proteina SOX11 (si/no)?" crlf)
    (bind ?proteina (read))
    (printout t "¿Presenta translocacion de los cromosomas 11 y 14 (si/no)?" crlf)
    (bind ?translocacion (read))
    (if (or (eq ?proteina si) (eq ?translocacion si))
        then
        (printout t crlf)
        (printout t "Tienes un linfoma del manto avanzado" crlf)
        (printout t crlf)
    else
        (printout t crlf)
        (printout t "Tienes un linfoma del manto no avanzado" crlf)
        (printout t crlf)
    )
)

(defrule Preguntar-Linfoma-Burkitt
    (posible_linfoma_burkitt si)
    =>
    (printout t "¿El paciente es Europeo o Africano (europeo/africano)?" crlf)
    (bind ?etnia (read))
    (printout t "¿Presenta translocacion de los cromosomas 8 y 14 (si/no)?" crlf)
    (bind ?translocacion (read))
    (printout t "¿Presenta masas en la mandíbula (si/no)?" crlf)
    (bind ?masas (read))
    (printout t "¿Presenta masas en el abdomen (si/no)?" crlf)
    (bind ?masas_abdomen (read))
    (if (or (and (eq ?etnia europeo) (eq ?translocacion si)) (and (eq ?etnia europeoo) (eq ?masas_abdomen si)))
        then
        (printout t crlf)
        (printout t "Tienes un linfoma de Burkitt esporádico" crlf)
        (printout t crlf)
        else
            (if (and (eq ?etnia africano) (eq ?masas si))
                then
                (printout t crlf)
                (printout t "Tienes un linfoma de Burkitt endémico" crlf)
                (printout t crlf)
            else
                (if (eq ?*alta_posibilidad_linfoma* si)
                    then
                    (printout t crlf)
                    (printout t "No presentas sintomas de ningun tipo de linfoma, sin embargo diste alta probabilidad de linfoma, le pedimos que revise sus respuestas" crlf)
                    (printout t crlf)
                else
                    (printout t crlf)
                    (printout t "No tienes sintomas de un linfoma, acuda a un especialista de bultos por infección" crlf)
                    (printout t crlf)
                )
            )
  
    )
)





    


















