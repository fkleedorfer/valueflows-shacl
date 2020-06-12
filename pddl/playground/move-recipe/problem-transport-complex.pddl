(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Rolf Alice Bob Claudia Maria - actor
    GrannySmith - resourceClass
    Truck1 - truck
    Car1 - car 
)

(:init
    
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap-rl- send-and-transfer Alice Apples Rossatz)

    (currentLocation Bob Wien)
    (intent-a-rrl- send-and-transfer Bob Apples Wien)

    (currentLocation Rolf Gedersdorf)
    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (primaryAccountable Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (intent-ap-rl- lend Rolf Truck1 Gedersdorf)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    
    (intent-ap-r-- deliver-taxi-service Maria Car1)

    (currentlocation Claudia Krems)    
    (intent-ap---- deliver-transport-service Claudia)
    
)

(:goal 
    (and
        (not 
            (exists (?a - action ?p ?r - actor ?s - resource ?l - location ?c - resourceClass)
                (and
                    (or
                        (commitment-r- ?a ?p ?r ?s ?l)
                        (commitment--c ?a ?p ?r ?s ?c)

            
                        (intent ?a ?p ?r ?s ?l ?c)
                        (intent-aprr-c ?a ?p ?r ?s ?c)
                        (intent-apr-lc ?a ?p ?r ?l ?c)
                        (intent-ap-rlc ?a ?p ?s ?l ?c)
                        (intent-a-rrlc ?a ?r ?s ?l ?c)
                        (intent-apr--c ?a ?p ?r ?c)
                        (intent-ap-r-c ?a ?p ?s ?c)
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
