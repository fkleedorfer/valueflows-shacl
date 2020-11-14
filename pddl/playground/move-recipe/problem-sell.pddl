(define 
    (problem sell) 
    (:domain valueflows)
(:objects 
    Sum1 - money
    Rossatz - location
    Alice Bob - actor
    Apples - resource
    Truck1 - truck
)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (persistent-intent-a-r---c transfer Alice MoneyClass)

    (currentLocation Bob Rossatz)
    (primaryAccountable Sum1 Bob)
    (custodian Sum1 Bob)
    (resourceClassification Sum1 MoneyClass)
    (intent-aprr--- consume Bob Bob Apples)
    ;(debug)
)
(:goal
    (and
    ;(fulfillment-aprrl-- consume Bob Bob Apples Rossatz)
    ;(commitment-aprrl-- consume Bob Bob Apples Rossatz)
    (problemSolved)
    ;;(intent-a-rr--- transfer Bob Apples)
    ;;(intent-a-rr--- transfer Alice sum1)
    ;;(commitment-aprrl-- transfer Alice Bob Apples Rossatz)
    ;;(commitment-aprrl-- transfer Bob Alice sum1 Rossatz)
    ;(custodian Apples Bob)
    ;(primaryAccountable Apples Bob)
    ;(custodian Sum1 Alice)
    )
)

(:metric minimize (total-cost))
)