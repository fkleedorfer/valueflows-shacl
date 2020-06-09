(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Rolf Alice Bob Claudia Maria - actor
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
    (intent send-and-transfer Alice null Apples Rossatz)

    (currentLocation Bob Wien)
    (intent send-and-transfer null Bob Apples Wien)

    (currentLocation Rolf Gedersdorf)
    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (primaryAccountable Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (intent lend Rolf null Truck1 Gedersdorf)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (intent deliver-taxi-service Maria null Car1 null)

    (currentlocation Claudia Krems)    
    (intent deliver-transport-service Claudia null null null)
    
)

(:goal 
    (and
        (custodian Apples Bob)
        (custodian Truck1 Rolf)
        ;s(currentLocation Claudia Krems)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
