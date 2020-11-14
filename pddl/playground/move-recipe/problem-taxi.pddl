(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems - location
    Claudia Maria Bob - actor
    Car1 - car 
    lasercutter1 thing1 woodenboard1 - resource
    LaserCutter WoodenBoard LaserCutterProduct - resourceClassType
    cutout - recipeProcess
    consumeWoodenboard useLaserCutter produceLaserCutterProduct - recipeFlow
    
)

(:init
    (potentialResource thing1)
    
    (recipeInputOf cutout consumeWoodenboard)
    (recipeFlowDef consumeWoodenboard consume WoodenBoard)
    (recipeInputOf cutout useLaserCutter)
    (recipeFlowDef useLaserCutter use LaserCutter)
    (recipeOutputOf cutout produceLaserCutterProduct)
    (recipeFlowDef produceLaserCutterProduct produce LaserCutterProduct)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (persistent-intent-ap----c deliver-service Maria TaxiServiceClass)

    (currentlocation Claudia Krems)
    (custodian woodenboard1 Claudia)
    (resourceClassification woodenboard1 WoodenBoard)
    (primaryAccountable woodenboard1 Claudia)
    (isCarryable woodenboard1)
    (currentLocation woodenboard1 Wien)
    (intent-apr---c use Claudia Claudia LaserCutterProduct )

    (currentLocation Bob Wien)
    (currentLocation lasercutter1 Wien)
    (resourceClassification lasercutter1 LaserCutter)
    (custodian lasercutter1 Bob)
    (primaryAccountable lasercutter1 Bob)
    (intent-ap-r--- lend Bob lasercutter1)
    
)
    
(:goal 
    (and 
        (fulfillment-aprrl-- consume Claudia Claudia woodenboard1 Wien)
        (fulfillment-aprrl-- use Claudia Claudia lasercutter1 Wien)
        (fulfillment-aprrl-c produce Claudia Claudia thing1 Wien LaserCutterProduct)
        (custodian thing1 Claudia)
        (problemSolved)
    )
)

)
