(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems - location
    Claudia Maria Driver Passenger - actor
    Car1 - car 
    Car2 - car
)

(:init
    (currentLocation Maria Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (currentLocation Car1 Krems)
    (intent use Maria Maria Car1 null)
    (intent use Maria Maria Car1 null)
    (intent move Maria Maria Car1 null)

    (currentlocation Claudia Krems)
    (intent mount null Claudia null Krems)
    (intent mount Maria null Car1 null)
    (intent dismount null Claudia null Wien)
    (intent dismount Maria null Car1 null)
)

(:goal 
    ( and
        (currentLocation Claudia Wien)
        (currentLocation Maria Krems)
        (not(using Maria Car1))
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
