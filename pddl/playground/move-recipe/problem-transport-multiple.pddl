(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz Stein - location
    Claudia Alice Bob Albert - actor
    Apples Wine - resource
    Truck1 - truck
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap-rl- send-and-transfer Alice Apples Rossatz)

    (currentLocation Wine Stein)
    (currentLocation Albert Stein)
    (custodian Wine Albert)
    (primaryAccountable Wine Albert)    
    (intent-ap-rl- send-and-transfer Albert Wine Stein )


    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (persistent-intent-ap---c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (intent-a-rrl- send-and-transfer Bob Apples Wien)

    (currentLocation Bob Wien)
    (intent-a-rrl- send-and-transfer Bob Wine Wien)

)
    
(:goal 
    (and
        (not 
            (exists (?a - action ?p ?r - actor ?s - resource ?l - location ?c - resourceClassType)
                (and
                    (or
                        (commitment-r- ?a ?p ?r ?s ?l)
                        (commitment--c ?a ?p ?r ?s ?c)

            
                        (intent ?a ?p ?r ?s ?l ?c)
                        (intent-apr--c ?a ?p ?r ?c)
                        (intent-ap-r-c ?a ?p ?s ?c)
                        (intent-apr-lc ?a ?p ?r ?l ?c)
                        (intent-ap--lc ?a ?p ?l ?c)
                        (intent-a-r-lc ?a ?r ?l ?c)
                        (intent-apr--c ?a ?p ?r ?c)
                        (intent-ap---c ?a ?p ?c)
                        (intent-ap---c ?a ?p ?c)

                        (intent-aprrl- ?a ?p ?r ?s ?l)
                        (intent-aprr-- ?a ?p ?r ?s) 
                        (intent-apr-l- ?a ?p ?r ?l)
                        (intent-ap-rl- ?a ?p ?s ?l)
                        (intent-a-rrl- ?a ?r ?s ?l)
                        (intent-apr--- ?a ?p ?r)
                        (intent-ap-r-- ?a ?p ?s)
                        (intent-ap---- ?a ?p)
                    )
                )
            )
        )
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
