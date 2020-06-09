(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems - location
    Claudia Maria - actor
    Car1 - car 
    drive - recipe1role1resource
    fuse fmove - recipeFlow
)

(:init
    (currentLocation Maria Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (currentLocation Car1 Krems)

    (recipeClauseOf fuse drive)
    (flowAction fuse use)
    (flowProvider fuse role1)
    (flowReceiver fuse role1)
    (flowResource fuse resource1)
    (flowLocation fuse locationOfRole1)

    (recipeClauseOf fmove drive )
    (flowAction fmove move)
    (flowProvider fmove role1)
    (flowReceiver fmove role1)
    (flowResource fmove resource1)
    (flowLocation fmove otherLocation)

)
    
(:goal 
        (currentLocation Maria Wien)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
