(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Rolf Alice Bob Claudia Maria - actor
    GrannySmith - resourceClassType
    Truck1 - truck
    Car1 - car 
    Anything - resourceClassType
)

(:init
    
    
    (currentLocation Bob Wien)
    (intent-a-r-lc transfer-custody Bob Wien Anything)

    
)

(:goal 
    (exists (?pro - actor ?res - resource ?loc - location ?cla - resourceClassType)
        (or
            (commitment-r- transfer-custody Bob ?pro ?res ?loc)
            (commitment--c transfer-custody Bob ?pro ?res ?cla)
        )
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
