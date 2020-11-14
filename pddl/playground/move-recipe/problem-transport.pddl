(define 
    (problem transport) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
    Sum1 Sum2 - money
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (persistent-intent-a-r---c transfer Alice MoneyClass)

    (currentLocation Truck1 Wien)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)

    (currentLocation Claudia Wien)
    (persistent-intent-a-r---c transfer Claudia MoneyClass)
    (providesService Claudia TransportServiceClass)

    
    (currentLocation Bob Wien)
    
    (custodian Sum1 Bob)
    (primaryAccountable Sum1 Bob)
    (resourceClassification Sum1 MoneyClass)

    (custodian Sum2 Bob)
    (primaryAccountable Sum2 Bob)
    (resourceClassification Sum2 MoneyClass)
    (intent-aprrl-- consume Bob Bob Apples Wien)
)
(:goal
    (and
    
    (problemSolved)
    (fulfillment-aprrl-- consume Bob Bob Apples Wien)

    ;(currentLocation Alice Wien)

    ;(intent-ap----c deliver-service Claudia TransportServiceClass)
    ;(intent-aprr--- transfer-custody Alice Claudia Apples)
    ;(intent-aprr--- transfer-all-rights Claudia Bob Apples)
    ;(intent-aprr--- transfer Bob Alice Sum1)
    ;(intent-a-rrl-- transfer Bob Apples Wien)
    ;(intent-ap-rl-- transfer-custody Alice Apples Rossatz)
    ;(intent-aprrl-- transfer Alice Bob Apples Wien)
    ;(not (intent-aprr--- consume Bob Bob Apples))
    ;(fulfillment-aprrl-- consume Bob Bob Apples Wien)
    ;(custodian Sum2 Claudia)
    ;(custodian Sum1 Alice)
   ; (primaryAccountable Apples Bob)
    )
    
)

(:metric minimize (total-cost))
)