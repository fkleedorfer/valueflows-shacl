(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems - location
    Claudia Maria - actor
    Car1 - car 
)

(:init
    (currentLocation Maria Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (currentLocation Car1 Krems)

    (intent-aprrl-- use Maria Maria Car1 Krems)
    (intent-apr-l-- travel Maria Maria Wien)
)

(:goal 
        (currentLocation Maria Wien)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
