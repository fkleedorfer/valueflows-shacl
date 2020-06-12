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
    (persistent-intent-ap---c deliver-service Maria TaxiServiceClass)

    (currentlocation Claudia Krems)
    (intent-apr-l- travel Claudia Claudia Wien)
)
    
(:goal 
    (and
        ;(intent-ap-r-c deliver-service Maria Car1 TaxiServiceClass)
        ;(not (intent-apr-l- travel Claudia Claudia Wien))
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
                        (intent-ap---- ?a ?p)                 )
                )
            )
        )
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
