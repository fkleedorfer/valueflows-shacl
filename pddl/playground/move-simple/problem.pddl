(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien - location
    Alice Bob Claudia - actor
    GrannySmith - resourceClass
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (currentLocation Apples Rossatz)
    (currentLocation Alice Rossatz)
    (resourceClassification Apples GrannySmith)
    (custodian Apples Alice)
    (primaryAccountable Apples Alice)    
    (currentlocation Claudia Krems)
    (transporter Claudia)
    (currentLocation Bob Wien)
    (stationary Bob)
)

(:goal 
    (and 
        ( custodian Apples Bob)
        (primaryAccountable Apples Bob)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
