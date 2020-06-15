(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap-rl-- transfer-custody Alice Apples Rossatz)

    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (persistent-intent-ap----c deliver-service Claudia TransportServiceClass)

    (currentLocation Bob Wien)
    (intent-a-rrl-- transfer-custody Bob Apples Wien)

)
(:goal
   (problemSolved)
)

(:metric minimize (total-cost))
)
