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
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (intent deliver-taxi-service Maria null Car1 null)

    (currentlocation Claudia Krems)
    (intent travel Claudia Claudia null null)
)
    
(:goal 
    (and
        ;(containedIn Claudia Car1)
        (currentLocation Claudia Wien)
        (currentLocation Maria Krems)
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
