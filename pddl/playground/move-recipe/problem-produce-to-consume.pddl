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

    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)

    (currentLocation raisins1 Rossatz)
    (resourceClassification raisins1 Raisins)
    (custodian raisins1 Alice)
    (primaryAccountable raisins1 Alice)    

    (currentLocation oven1 Rossatz)
    (resourceClassification oven1 Oven)
    (custodian oven1 Alice)
    (primaryAccountable oven1 Alice) 

    (intent-apr---c consume Alice Alice Applestrudel)
)
    
(:goal
    (problemSolved)
)

;(:metric minimize (cost))
)
