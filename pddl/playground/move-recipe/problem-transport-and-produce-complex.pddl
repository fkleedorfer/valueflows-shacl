(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz Krems - location
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

    (currentLocation Claudia Krems)
    (currentLocation Truck1 Krems)
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
    (problemSolved)
)

;(:metric minimize (cost))
)
