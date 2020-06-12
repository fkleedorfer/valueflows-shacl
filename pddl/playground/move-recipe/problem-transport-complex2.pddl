(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples Apples2 - resource
    Rossatz Krems Wien Gedersdorf Stein - location
    Rolf Alice Bob Claudia Maria Leopold - actor
    GrannySmith - resourceClassType
    Truck1 - truck
    Car1 - car 
)

(:init
    (currentLocation OtherApples Stein)
    (resourceClassification OtherApples GrannySmith)

    (currentLocation Leopold Gedersdorf)
    (persistent-intent-ap---c deliver-service Leopold TransportServiceClass)
    
    (currentLocation Apples Rossatz)
    (resourceClassification Apples GrannySmith)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap--lc send-and-transfer Alice Rossatz GrannySmith)

    (currentLocation Bob Wien)
    (intent-a-r-lc send-and-transfer Bob Wien GrannySmith)

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
    
    (persistent-intent-ap-r-c deliver-service Maria Car1 TaxiServiceClass)

    (currentlocation Claudia Krems)    
    (persistent-intent-ap---c deliver-service Claudia TransportServiceClass)
    
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
