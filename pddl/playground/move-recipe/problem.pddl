(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Alice Bob Claudia Rolf Maria - actor
    GrannySmith - resourceClass
    Truck1 - truck
    Car1 - car 
)

(:init
    
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    
    (currentLocation Bob Wien)

    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (currentLocation Rolf Gedersdorf)

    (currentLocation Maria Krems)
    (custodian Car1 Maria)
    (mayContainActors Car1)
    (isVehicle Car1)
    (currentLocation Car1 Krems)

    (currentlocation Claudia Krems)    

    
)

(:goal 
    (and
        (custodian Apples Bob)
        (primaryAccountable Apples Bob)
       ; (custodian Truck1 Rolf)
       ; (currentLocation Maria Krems)
       ; (currentLocation Claudia Krems)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
