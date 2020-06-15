(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Rossatz - location
    Alice Bob - actor
    Car - resource
)

(:init
    (currentLocation Car Rossatz)
    (currentLocation Alice Rossatz)
    (custodian Car Alice)
    (primaryAccountable Car Alice)
    (persistent-intent-ap-r--- lend Alice Car)

    (currentLocation Bob Rossatz)
    (intent-aprr--- use Bob Bob Car)
)

(:goal 
    (and
        (custodian Car Bob)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
