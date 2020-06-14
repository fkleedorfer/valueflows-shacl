(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Truck1 - truck
    GrannySmith  Applestrudel  Raisins Oven - resourceClassType
    Apples raisins1 oven1 thing1 strudel1 - resource
    applestrudelProcess - recipeProcess
    consumeApples consumeRaisins useOven produceApplestrudel - recipeFlow
)

(:init
    (potentialResource thing1)

    (recipeInputOf applestrudelProcess consumeApples)
    (recipeFlowDef consumeApples consume GrannySmith)
    (recipeInputOf applestrudelProcess consumeRaisins)
    (recipeFlowDef consumeRaisins Raisins)
    (recipeInputOf applestrudelProcess useOven)
    (recipeFlowDef useOven use Oven)
    (recipeOutputOf applestrudelProcess produceApplestrudel)
    (recipeFlowDef produceApplestrudel produce Applestrudel)

    (currentLocation Alice Rossatz)
    (currentLocation Apples Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)  

    (persistent-intent-ap--lc transfer-custody Alice Rossatz GrannySmith) 
    (persistent-intent-ap--lc transfer-all-rights Alice Rossatz GrannySmith) 

    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (persistent-intent-ap---c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (resourceClassification raisins1 Raisins)
    (currentLocation raisins1 Wien)
    (custodian raisins1 Bob)
    (primaryAccountable raisins1 Bob)
    (resourceClassification oven1 Oven)
    (currentLocation oven1 Wien)
    (custodian oven1 Bob)
    (primaryAccountable oven1 Bob)



    (intent-apr--c consume Bob Bob Applestrudel)
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
