(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems Horn Linz - location
    Claudia Maria Rolf - actor
    Car1 - car 
)

(:init
    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (persistent-intent-ap-r- deliver-taxi-service Maria Car1 )
    ;(persistent-intent-apr-- travel Maria Maria)

    (currentlocation Claudia Horn)
    (intent-apr-l travel Claudia Claudia Wien)

    (currentlocation Rolf Krems)
    (intent-apr-l travel Rolf Rolf Linz)
    
)
    
(:goal 
    (and
        (not 
            (exists (?a - action ?p ?r - actor ?s - resource ?l - location)
                (and
                    (or
                        (commitment ?a ?p ?r ?s ?l)
                        ;(commitment transfer ?p ?r ?s ?l)
                        ; (commitment move ?p ?r ?s ?l)
                        ; (commitment goto ?p ?r ?s ?l)
                        ; (commitment transfer-all-rights ?p ?r ?s ?l)
                        ; (commitment transfer-custody ?p ?r ?s ?l)
                        ; (commitment mount ?p ?r ?s ?l)
                        ; (commitment dismount ?p ?r ?s ?l)
                        ; (commitment put-into ?p ?r ?s ?l)
                        ; (commitment take-out-of ?p ?r ?s ?l)
                        ; (commitment begin-use ?p ?r ?s ?l)
                        ; (commitment end-use ?p ?r ?s ?l)
                        ; (commitment use ?p ?r ?s ?l)
                        ; (commitment send-and-transfer ?p ?r ?s ?l)
                        ; (commitment deliver-taxi-service ?p ?r ?s ?l)
                        ; (commitment deliver-transport-service ?p ?r ?s ?l)
                        ; (commitment lend ?p ?r ?s ?l)
                        ; (commitment leave ?p ?r ?s ?l)
                        ; (commitment arrive ?p ?r ?s ?l)
                        ; (commitment drive ?p ?r ?s ?l)
                        ; (commitment travel ?p ?r ?s ?l)
            
                        (intent ?a ?p ?r ?s ?l)
                        (intent-aprr- ?a ?p ?r ?s) 
                        (intent-apr-l ?a ?p ?r ?l)
                        (intent-ap-rl ?a ?p ?s ?l)
                        (intent-a-rrl ?a ?r ?s ?l)
                        ;(intent--prrl ?p ?r ?s ?l)
                        (intent-apr-- ?a ?p ?r)
                        (intent-ap-r- ?a ?p ?s)
                        ; (intent-a-rr- ?a ?r ?s)
                        ; (intent--prr- ?p ?r ?s)
                        ; (intent-ap--l ?a ?p ?l)
                        ; (intent-a-r-l ?a ?r ?l)
                        ; (intent--pr-l ?p ?r ?l)
                        ; (intent-a--rl ?a ?s ?l)
                        ; (intent--p-rl ?p ?s ?l)
                        ; (intent---rrl ?r ?s ?l)
                        (intent-ap--- ?a ?p)
                        ; (intent-a-r-- ?a ?r)
                        ; (intent-a--r- ?a ?s)
                        ; (intent--pr-- ?p ?r)
                        ; (intent--p-r- ?p ?s)
                        ; (intent---rr- ?r ?s)
                        ; (intent-a---l ?a ?l)
                        ; (intent--p--l ?p ?l)
                        ; (intent---r-l ?r ?l)
                        ; (intent----rl ?s ?l)
                        ; (intent-a---- ?a)
                        ; (intent--p--- ?p)
                        ; (intent---r-- ?r)
                        ; (intent----r- ?s)
                        ; (intent-----l ?l)
                    )
                )
            )
        )
    )
)


;un-comment the following line if metric is needed
;(:metric minimize (???))
)
