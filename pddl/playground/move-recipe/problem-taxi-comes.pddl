(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems Horn Linz - location
    Claudia Maria Rolf - actor
    Car1 - car 
)

(:init
    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (intent deliver-taxi-service Maria null Car1 null)

    (currentlocation Claudia Horn)
    (intent leave Claudia Claudia null Horn)
    (intent arrive Claudia Claudia null Wien)

    (currentlocation Rolf Krems)
    (intent leave Rolf Rolf null Krems)
    (intent arrive Rolf Rolf null Linz)
)
    
(:goal 
    (and
        (currentLocation Claudia Wien)
        (currentLocation Rolf Linz)
        (not 
            (exists (?action - action ?actor1 ?actor2 - actor ?resource - resource ?location - location)
                (and 
                    (commitment ?action ?actor1 ?actor2 ?resource ?location)
                    (not (fulfillment ?action ?actor1 ?actor2 ?resource ?location))
                )
            )
        )
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
