(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Rolf Alice Bob Claudia Maria - actor
    GrannySmith - resourceClassType
    Truck1 - truck
    Car1 - car 
)

(:init
    
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap--lc transfer-custody Alice Rossatz GrannySmith)

    (currentLocation Bob Wien)
    (intent-a-r-lc transfer-custody Bob Wien GrannySmith)

    (currentLocation Rolf Gedersdorf)
    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (primaryAccountable Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (persistent-intent-ap-rl- lend Rolf Truck1 Gedersdorf)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (persistent-intent-ap-r-c deliver-service Maria Car1 TaxiServiceClass)

    (currentlocation Claudia Krems)    
    (persistent-intent-ap---c deliver-service Claudia TransportServiceClass)
    
)

(:goal 
    (problemSolved)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
