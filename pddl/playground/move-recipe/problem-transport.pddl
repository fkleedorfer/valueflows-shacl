(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent send-and-transfer Alice null Apples Rossatz)

    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (intent deliver-transport-service Claudia null null null)

    (currentLocation Bob Wien)
    (intent send-and-transfer null Bob Apples Wien)

)
    
(:goal 
    (and
        (custodian Apples Bob)
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
