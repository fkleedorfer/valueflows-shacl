(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples Apples2 - resource
    Rossatz Krems Wien Gedersdorf Stein - location
    Rolf Alice Bob Claudia Maria Leopold - actor
    GrannySmith - resourceClassType
    Truck1 - truck
    Car1 - car 
)

(:init
    (currentLocation OtherApples Stein)
    (resourceClassification OtherApples GrannySmith)

    (currentLocation Leopold Gedersdorf)
    (persistent-intent-ap----c deliver-service Leopold TransportServiceClass)
    
    (currentLocation Apples Rossatz)
    (resourceClassification Apples GrannySmith)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (intent-ap--l-c send-and-transfer Alice Rossatz GrannySmith)

    (currentLocation Bob Wien)
    (intent-a-r-l-c send-and-transfer Bob Wien GrannySmith)

    (currentLocation Rolf Gedersdorf)
    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (primaryAccountable Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (intent-ap-rl-- lend Rolf Truck1 Gedersdorf)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    
    (persistent-intent-ap-r--c deliver-service Maria Car1 TaxiServiceClass)

    (currentlocation Claudia Krems)    
    (persistent-intent-ap----c deliver-service Claudia TransportServiceClass)
    
)

(:goal
   (problemSolved)
)

(:metric minimize (total-cost))
)