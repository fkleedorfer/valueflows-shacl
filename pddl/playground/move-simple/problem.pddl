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
    (intent transfer-all-rights Alice null Apples Rossatz)
    (intent transfer-custody Alice null Apples Rossatz)
    
    (currentLocation Bob Wien)
    (intent transfer-all-rights null Bob Apples null)
    (intent transfer-custody null Bob Apples Wien)

    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (currentLocation Rolf Gedersdorf)
    (intent transfer-custody Rolf null Truck1 Gedersdorf)
    (intent transfer-custody null Rolf Truck1 Gedersdorf) ;might be too weak - should get the truck back from same actor

    (currentLocation Maria Krems)
    (custodian Car1 Maria)
    (mayContainActors Car1)
    (isVehicle Car1)
    (currentLocation Car1 Krems)
    (intent use Maria Maria Car1 null)
    (intent move Maria Maria Car1 null)
    (intent mount Maria null Car1 null)
    (intent dismount Maria null Car1 null)

    (currentlocation Claudia Krems)    
    (intent transfer-custody null Claudia Truck1 null); too strong! Truck1 should be ?truck - truck
    (intent transfer-custody Claudia null Truck1 null)
    (intent use Claudia Claudia Truck1 null)
    (intent move Claudia Claudia Truck1 null)
    (intent mount null Claudia null Krems)
    (intent dismount null Claudia null Gedersdorf)
    (intent mount null Claudia null Gedersdorf)
    (intent dismount null Claudia null Krems)
    (intent transfer-custody null Claudia null null)
    (intent transfer-custody Claudia null null null)

    
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
