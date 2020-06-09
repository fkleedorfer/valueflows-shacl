(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems Horn - location
    Claudia Maria - actor
    Car1 - car 
    taxi - recipe2roles1resource
    drive - recipe1role1resource    
)

(:init
    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (currentlocation Claudia Horn)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)


    (recipeFlow taxi use role1 role1 resource1 locationOfRole1) ; todo: restrict type of resource!
    (recipeFlow taxi mount role1 role2 resource1 locationOfRole2)
    (recipeFlow taxi move role1 role1 resource1 otherLocation)
    (recipeFlow taxi dismount role1 role2 resource1 locationOfRole2)

    (recipeFlow drive use role1 role1 resource1 locationOfRole1) 
    (recipeFlow drive move role1 role1 resource1 otherLocation)
)
    
(:goal 
    (and
        (currentLocation Claudia Wien)
        (currentLocation Maria Krems)
    )

)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
