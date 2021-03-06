(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Rossatz - location
    Alice Bob - actor
    Apples - resource
    give take - recipe2roles1resource
    f1 - recipeFlow
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (currentLocation Alice Rossatz)
    (currentLocation Bob Rossatz)
    (currentLocation Apples Rossatz)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)
    
    (recipeClauseOf f1 give)
    (flowAction f1 transfer) 
    (flowProvider f1 role1)
    (flowReceiver f1 role2)
    (flowResource f1 resource1)
    (flowLocation f1 locationOfRole1)

)

(:goal 
    (and
       ; (intent transfer Alice Bob null Rossatz) 
       (custodian Apples Bob)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
