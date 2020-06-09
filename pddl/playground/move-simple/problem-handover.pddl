(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien - location
    Claudia Bob - actor
    Apples - resource
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (currentLocation Claudia Wien)
    (currentLocation Bob Wien)
    (currentLocation Apples Wien)
    (custodian Apples Claudia)
    (intent transfer-custody Claudia Bob Apples null)
)

(:goal 
    (and 
        (custodian Apples Bob)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
