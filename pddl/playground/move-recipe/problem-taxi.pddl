(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems - location
    Claudia Maria - actor
    Car1 - car 
    taxi - recipe2roles1resource
    fuse fmount fmove fdismount - recipeFlow
)

(:init
    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (currentlocation Claudia Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)

    (recipeClauseOf fuse taxi)
    (flowAction fuse use)
    (flowProvider fuse role1)
    (flowReceiver fuse role1)
    (flowResource fuse resource1)
    (flowLocation fuse locationOfRole1)

    (recipeClauseOf fmount taxi)
    (flowAction fmount mount)
    (flowProvider fmount role1)
    (flowReceiver fmount role2)
    (flowResource fmount resource1)
    (flowLocation fmount locationOfRole2)


    ; (recipeFlow taxi use role1 role1 resource1 locationOfRole1) ; todo: restrict type of resource!
    ; (recipeFlow taxi mount role1 role2 resource1 locationOfRole2)
    ; (recipeFlow taxi move role1 role1 resource1 otherLocation)
    ; (recipeFlow taxi dismount role1 role2 resource1 locationOfRole2)
)
    
(:goal 
    (and
        (containedIn Claudia Car1)
        ; (currentLocation Claudia Wien)
        ; (currentLocation Maria Krems)
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
