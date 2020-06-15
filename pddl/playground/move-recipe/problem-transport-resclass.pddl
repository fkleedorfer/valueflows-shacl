(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
    GrannySmith - resourceClassType
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap--l-c send-and-transfer Alice Rossatz GrannySmith)

    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)
    (intent-ap----c deliver-service Claudia TransportServiceClass)
    (persistent-intent-apr---- travel Claudia Claudia)

    (currentLocation Bob Wien)
    (intent-a-r-l-c send-and-transfer Bob Wien GrannySmith)

)
(:goal
   (problemSolved)
)

(:metric minimize (total-cost))
)