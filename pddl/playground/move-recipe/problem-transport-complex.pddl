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
    Sum1 Sum2 Sum3 Sum4 Sum5 - money
)

(:init
    
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (persistent-intent-a-r---c transfer Alice MoneyClass)
    
    (currentLocation Bob Wien)
    (custodian Sum1 Bob)
    (primaryAccountable Sum1 Bob)
    (resourceClassification Sum1 MoneyClass)

    (custodian Sum2 Bob)
    (primaryAccountable Sum2 Bob)
    (resourceClassification Sum2 MoneyClass)

    (currentLocation Rolf Gedersdorf)
    (currentLocation Truck1 Gedersdorf)
    (custodian Truck1 Rolf)
    (primaryAccountable Truck1 Rolf)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (persistent-intent-a-r---c transfer Rolf MoneyClass)
    ;(persistent-intent-ap-rl-- lend Rolf Truck1 Gedersdorf)

    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (persistent-intent-a-r---c transfer Maria MoneyClass)
    (providesService Maria TaxiServiceClass)

    (currentlocation Claudia Krems)    
    (persistent-intent-a-r---c transfer Claudia MoneyClass)
    (providesService Claudia TransportServiceClass)
    (custodian Sum3 Claudia)
    (primaryAccountable Sum3 Claudia)
    (resourceClassification Sum3 MoneyClass)
    (custodian Sum4 Claudia)
    (primaryAccountable Sum4 Claudia)
    (resourceClassification Sum4 MoneyClass)


    
    (intent-aprrl-- consume Bob Bob Apples Wien)


    (debug)
)

(:goal
   (and
   ;(custodian Apples Bob)
   ;(fulfillment-aprrl-- consume Bob Bob Apples Wien)
   ;ss(problemSolved)
   )
)

(:metric minimize (total-cost))
)
