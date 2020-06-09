(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Claudia Alice Bob - actor
    Apples - resource
    Truck1 - truck
    transport transport2 - recipe2roles2resources
    fpickup fuse-truck fmove fdropoff - recipeFlow

)

(:init
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
   
    (currentLocation Claudia Rossatz)
    (currentLocation Truck1 Rossatz)
    (isVehicle Truck1)
    (mayContainResources Truck1)
    (custodian Truck1 Claudia)

    (currentLocation Bob Wien)


)
    
(:goal 
    (and
        (custodian Apples Bob)
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
