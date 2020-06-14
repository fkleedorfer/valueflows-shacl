(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
    GrannySmith - resourceClassType
    Applestrudel - resourceClassType
    thing1 - resource
)

(:init
    (potentialResource thing1)
    (requiresIngredient Applestrudel GrannySmith)

    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    

    (intent-apr--c consume Alice Alice Applestrudel)
)
    
(:goal
    (and
        (not 
            (exists (?a - action ?p ?r - actor ?s - resource ?l - location ?c - resourceClassType)
                (and
                    (or
                        (commitment-r- ?a ?p ?r ?s ?l)
                        ;(commitment--c ?a ?p ?r ?s ?c)
                        (commitment ?a ?p ?r ?s ?l ?c)
            
                        (intent ?a ?p ?r ?s ?l ?c)
                        (intent-apr--c ?a ?p ?r ?c)
                        (intent-ap-r-c ?a ?p ?s ?c)
                        (intent-apr-lc ?a ?p ?r ?l ?c)
                        (intent-ap--lc ?a ?p ?l ?c)
                        (intent-a-r-lc ?a ?r ?l ?c)
                        (intent-apr--c ?a ?p ?r ?c)
                        (intent-a-r--c ?a ?r ?c)
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

;(:metric minimize (cost))
)
