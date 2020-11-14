(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz Stein - location
    Claudia Alice Bob Albert - actor
    Apples Wine - resource
    Truck1 - truck
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap-rl-- transfer-custody Alice Apples Rossatz)

    (currentLocation Wine Stein)
    (currentLocation Albert Stein)
    (custodian Wine Albert)
    (primaryAccountable Wine Albert)    
    (intent-ap-rl-- transfer-custody Albert Wine Stein )


    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (persistent-intent-ap----c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (intent-a-rrl-- transfer-custody Bob Apples Wien)

    (currentLocation Bob Wien)
    (intent-a-rrl-- transfer-custody Bob Wine Wien)

)
(:goal
   (problemSolved)
)

(:metric minimize (total-cost))
)