(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz Krems Gedersdorf - location
    Claudia Alice Bob Rolf Maria - actor
    truck1 - truck
    car1 - car
    GrannySmith Applestrudel Raisins Oven - resourceClassType
    apples1 raisins1 oven1 thing1 strudel1 - resource
    applestrudelProcess - recipeProcess
    consumeApples consumeRaisins useOven produceApplestrudel - recipeFlow
)

(:init
    (potentialResource thing1)

    (recipeInputOf applestrudelProcess consumeApples)
    (recipeFlowDef consumeApples consume GrannySmith)
    (recipeInputOf applestrudelProcess consumeRaisins)
    (recipeFlowDef consumeRaisins consume Raisins)
    (recipeInputOf applestrudelProcess useOven)
    (recipeFlowDef useOven use Oven)
    (recipeOutputOf applestrudelProcess produceApplestrudel)
    (recipeFlowDef produceApplestrudel produce Applestrudel)

    (currentLocation Alice Rossatz)
    (currentLocation apples1 Rossatz)
    (resourceClassification apples1 GrannySmith)
    (custodian apples1 Alice)
    (primaryAccountable apples1 Alice)  

    (persistent-intent-ap--l-c transfer-custody Alice Rossatz GrannySmith) 
    (persistent-intent-ap--l-c transfer-all-rights Alice Rossatz GrannySmith) 

    (currentLocation Rolf Gedersdorf)
    (currentLocation truck1 Gedersdorf)
    (custodian truck1 Rolf)
    (primaryAccountable truck1 Rolf)
    (isVehicle truck1)
    (mayContainResources truck1)
    (persistent-intent-ap-r--- lend Rolf truck1)

    (currentLocation Maria Krems)
    (currentLocation car1 Krems)
    (custodian car1 Maria)
    (isVehicle car1)
    (mayContainActors car1)
    (persistent-intent-ap-r--c deliver-service Maria car1 TaxiServiceClass)


    (currentLocation Claudia Krems)
    (persistent-intent-ap----c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (resourceClassification raisins1 Raisins)
    (currentLocation raisins1 Wien)
    (custodian raisins1 Bob)
    (primaryAccountable raisins1 Bob)
    (resourceClassification oven1 Oven)
    (currentLocation oven1 Wien)
    (custodian oven1 Bob)
    (primaryAccountable oven1 Bob)

    (intent-apr---c consume Bob Bob Applestrudel)
)
    
(:goal
    (problemSolved)
)

;(:metric minimize (cost))
)
