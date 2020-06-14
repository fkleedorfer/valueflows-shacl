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
    strudel1 - resource
    ApplestrudelProcess - recipeProcess
    raisins1 - resource
    Raisins - resourceClassType

)

(:init
    (potentialResource thing1)
    (recipeInputOf applestrudelProcess GrannySmith)
    (recipeInputOf applestrudelProcess Raisins)
    (recipeOutputOf applestrudelProcess Applestrudel)

    (resourceClassification raisins1 Raisins)
    (currentLocation raisins1 Rossatz)
    (custodian raisins1 Alice)
    (primaryAccountable raisins1 Alice)

    (currentLocation Alice Rossatz)
    (currentLocation Apples Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)   
    (intent-ap-rl- transfer-custody Alice Apples Rossatz) 
    (intent-ap-rl- transfer-all-rights Alice Apples Rossatz) 
    
    ; (resourceClassification strudel1 Applestrudel)
    ; (custodian strudel1 Alice)
    ; (currentLocation strudel1 Rossatz)
    ; (primaryAccountable strudel1 Alice)
    ;(intent-ap-rl- transfer-custody Alice strudel1 Rossatz) 
    ;(intent-ap-rl- transfer-all-rights Alice strudel1 Rossatz) 

    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (persistent-intent-ap---c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (intent-apr--c consume Bob Bob Applestrudel)
    ;(intent-apr--c consume Alice Alice Applestrudel)
    ;(intent-a-r-lc transfer-custody Bob Wien GrannySmith)
    ;(intent-a-rr-- transfer-all-rights Bob Apples) 
)
    
(:goal
    (and
        (not 
            (exists (?a - action ?p ?r - actor ?s - resource ?l - location ?c - resourceClassType)
                (and
                    (or
                        (commitment-r- ?a ?p ?r ?s ?l)
                        ;(commitment--c ?a ?p ?r ?l ?c)
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
