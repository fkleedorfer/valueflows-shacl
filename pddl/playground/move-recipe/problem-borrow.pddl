(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Alice Bob - actor
    Car - resource
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (currentLocation Car Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Car Alice)
    (primaryAccountable Car Alice)
    (intent lend Alice null Car null)

    (currentLocation Bob Rossatz)
    (intent use Bob Bob Car null)
)

(:goal 
    (and
       ; (intent transfer Alice Bob null Rossatz) 
       (custodian Car Bob)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
