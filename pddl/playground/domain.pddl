

(define (domain valueflows)


(:requirements :adl )

(:types 
    thing
    resource - thing 
    actor - thing
    vehicle - resource
    truck - vehicle
    car - vehicle
    resourceClass
    location
    action
)

(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use send-and-transfer deliver-taxi-service deliver-transport-service lend leave arrive drive travel - action
)

(:functions (total-cost - numeric))

(:predicates 
    (currentLocation ?t - thing ?l - location) ; t is at location l
    (resourceClassification ?r - resource ?c - resourceClass )
    (custodian ?r - resource ?a - actor ) ; a is currently in custody of r
    (primaryAccountable ?r - resource ?a - actor) ; a is the owner of r
    (intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location)

    (intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (intent-aprr- ?action - action ?provider ?receiver - actor ?r - resource)
    (intent-apr-l ?action - action ?provider ?receiver - actor ?l - location)    
    (intent-ap-rl ?action - action ?provider - actor ?r - resource ?l - location)
    (intent-a-rrl ?action - action ?receiver - actor ?r - resource ?l - location)
    ;(intent--prrl ?provider ?receiver - actor ?r - resource ?l - location)
    (intent-apr-- ?action - action ?provider ?receiver - actor )
    (intent-ap-r- ?action - action ?provider - actor ?r - resource)
    ; (intent-a-rr- ?action - action ?receiver - actor ?r - resource)
    ; (intent--prr- ?provider ?receiver - actor ?r - resource)
    ; (intent-ap--l ?action - action ?provider - actor ?l - location)
    ; (intent-a-r-l ?action - action ?receiver - actor ?l - location)
    ; (intent--pr-l ?provider ?receiver - actor ?l - location)
    ; (intent-a--rl ?action - action ?r - resource ?l - location)
    ; (intent--p-rl ?provider - actor ?r - resource ?l - location)
    ; (intent---rrl ?receiver - actor ?r - resource ?l - location)
    (intent-ap--- ?action - action ?provider - actor)
    ; (intent-a-r-- ?action - action ?receiver - actor)
    ; (intent--pr-- ?provider ?receiver - actor)
    ; (intent-a--r- ?action - action ?r - resource)
    ; (intent--p-r- ?provider - actor ?r - resource)
    ; (intent---rr- ?receiver - actor ?r - resource)
    ; (intent-a---l ?action - action ?l - location)
    ; (intent--p--l ?provider - actor ?l - location)
    ; (intent---r-l ?receiver - actor ?l - location)
    ; (intent----rl ?r - resource ?l - location)
    ; (intent-a---- ?action - action)
    ; (intent--p--- ?provider - actor)
    ; (intent---r-- ?receiver - actor)
    ; (intent----r- ?r - resource)
    ; (intent-----l ?l - location)
    
    (persistent-intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (persistent-intent-aprr- ?action - action ?provider ?receiver - actor ?r - resource)
    (persistent-intent-apr-l ?action - action ?provider ?receiver - actor ?l - location)    
    (persistent-intent-ap-rl ?action - action ?provider - actor ?r - resource ?l - location)
    (persistent-intent-a-rrl ?action - action ?receiver - actor ?r - resource ?l - location)
    ;(persistent-intent--prrl ?provider ?receiver - actor ?r - resource ?l - location)
    (persistent-intent-apr-- ?action - action ?provider ?receiver - actor )
    (persistent-intent-ap-r- ?action - action ?provider - actor ?r - resource)
    ; (persistent-intent-a-rr- ?action - action ?receiver - actor ?r - resource)
    ; (persistent-intent--prr- ?provider ?receiver - actor ?r - resource)
    ; (persistent-intent-ap--l ?action - action ?provider - actor ?l - location)
    ; (persistent-intent-a-r-l ?action - action ?receiver - actor ?l - location)
    ; (persistent-intent--pr-l ?provider ?receiver - actor ?l - location)
    ; (persistent-intent-a--rl ?action - action ?r - resource ?l - location)
    ; (persistent-intent--p-rl ?provider - actor ?r - resource ?l - location)
    ; (persistent-intent---rrl ?receiver - actor ?r - resource ?l - location)
    (persistent-intent-ap--- ?action - action ?provider - actor)
    ; (persistent-intent-a-r-- ?action - action ?receiver - actor)
    ; (persistent-intent--pr-- ?provider ?receiver - actor)
    ; (persistent-intent-a--r- ?action - action ?r - resource)
    ; (persistent-intent--p-r- ?provider - actor ?r - resource)
    ; (persistent-intent---rr- ?receiver - actor ?r - resource)
    ; (persistent-intent-a---l ?action - action ?l - location)
    ; (persistent-intent--p--l ?provider - actor ?l - location)
    ; (persistent-intent---r-l ?receiver - actor ?l - location)
    ; (persistent-intent----rl ?r - resource ?l - location)    
    ; (persistent-intent-a---- ?action - action)
    ; (persistent-intent--p--- ?provider - actor)
    ; (persistent-intent---r-- ?receiver - actor)
    ; (persistent-intent----r- ?r - resource)
    ; (persistent-intent-----l ?l - location)


    
    (commitment ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (fulfillment ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (using ?a - actor ?r - resource) ; a is using r
    (isCarryable ?r - resource) ; an actor can move the resource
    (isVehicle ?r - resource) ; r is a vehicle
    (isPassive ?a - actor) ; actor cannot be in the provider/receiver role
    (mayContainResources ?r - resource) ; a truck, for example
    (mayContainActors ?a - actor) ; a means of person transport
    (containedIn ?rinside - thing ?rcontainer - resource) ; rinside is inside rcontainer
)


;(:functions (total-cost))

(:action commit 
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition 
        (intent ?action ?provider ?receiver ?resource ?location)
    :effect (and
        (commitment ?action ?provider ?receiver ?resource ?location)
        (not (intent ?action ?provider ?receiver ?resource ?location))
    )
)


(:action instantiate-intent
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent ?action ?provider ?receiver ?r ?l )
    :effect         
        (and
            (intent ?action ?provider ?receiver ?r ?l )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-aprr-
    :parameters ( ?action - action ?provider ?receiver - actor ?r - resource)
    :precondition
        (persistent-intent-aprr- ?action ?provider ?receiver ?r )
    :effect         
        (and
            (intent-aprr- ?action ?provider ?receiver ?r )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-apr-l
    :parameters ( ?action - action ?provider ?receiver - actor ?l - location)    
    :precondition
        (persistent-intent-apr-l ?action ?provider ?receiver ?l )
    :effect         
        (and
            (intent-apr-l ?action ?provider ?receiver ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-ap-rl
    :parameters ( ?action - action ?provider - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-ap-rl ?action ?provider ?r ?l )
        :effect         
        (and
            (intent-ap-rl ?action ?provider ?r ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-a-rrl
    :parameters ( ?action - action ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-a-rrl ?action ?receiver ?r ?l )
    :effect         
        (and
            (intent-a-rrl ?action ?receiver ?r ?l )
            (increase (total-cost) 1)
        )
    )
; (:action instantiate-intent--prrl
;     :parameters ( ?provider ?receiver - actor ?r - resource ?l - location)
;     :precondition
;         (persistent-intent--prrl ?provider ?receiver ?r ?l )
;     :effect         
;         (intent--prrl ?provider ?receiver ?r ?l )
    
;     )
(:action instantiate-intent-apr--
    :parameters ( ?action - action ?provider ?receiver - actor)
    :precondition
        (persistent-intent-apr-- ?action ?provider ?receiver)
        :effect         
        (and
            (intent-apr-- ?action ?provider ?receiver)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap-r-
    :parameters ( ?action - action ?provider - actor ?r - resource)
    :precondition
        (persistent-intent-ap-r- ?action ?provider ?r )
        :effect         
        (and
            (intent-ap-r- ?action ?provider ?r )
            (increase (total-cost) 1)
        )
)
; (:action instantiate-intent-a-rr- 
;     :parameters (?action - action ?receiver - actor ?r - resource)
;     :precondition
;         (persistent-intent-a-rr- ?action ?receiver ?r)
;         :effect         
;         (intent-a-rr- ?action ?receiver ?r)
    
;     )
; (:action instantiate-intent--prr-
;     :parameters ( ?provider ?receiver - actor ?r - resource)
;     :precondition
;         (persistent-intent--prr- ?provider ?receiver ?r )
;         :effect         
;         (intent--prr- ?provider ?receiver ?r )
    
;     )
; (:action instantiate-intent-ap--l
;     :parameters ( ?action - action ?provider - actor ?l - location)
;     :precondition
;         (persistent-intent-ap--l ?action ?provider ?l )
;         :effect         
;         (intent-ap--l ?action ?provider ?l )
    
;     )
; (:action instantiate-intent-a-r-l 
;     :parameters (?action - action ?receiver - actor ?l - location)
;     :precondition
;         (persistent-intent-a-r-l ?action ?receiver ?l )
;         :effect         
;         (intent-a-r-l ?action ?receiver ?l )
    
;     )
; (:action instantiate-intent--pr-l
;     :parameters ( ?provider ?receiver - actor ?l - location)
;     :precondition
;         (persistent-intent--pr-l ?provider ?receiver ?l )
;         :effect         
;         (intent--pr-l ?provider ?receiver ?l )
    
;     )
; (:action instantiate-intent-a--rl
;     :parameters ( ?action - action ?r - resource ?l - location)
;     :precondition
;         (persistent-intent-a--rl ?action ?r ?l )
;         :effect         
;         (intent-a--rl ?action ?r ?l )
    
;     )
; (:action instantiate-intent--p-rl
;     :parameters ( ?provider - actor ?r - resource ?l - location)
;     :precondition
;         (persistent-intent--p-rl ?provider ?r ?l )
;         :effect         
;         (intent--p-rl ?provider ?r ?l )
    
;     )
; (:action instantiate-intent---rrl
;     :parameters ( ?receiver - actor ?r - resource ?l - location)
;     :precondition
;         (persistent-intent---rrl ?receiver ?r ?l )
;         :effect         
;         (intent---rrl ?receiver ?r ?l )
    
;     )
(:action instantiate-intent-ap---
    :parameters ( ?action - action ?provider - actor)
    :precondition
        (persistent-intent-ap--- ?action ?provider )
        :effect         
        (and
            (intent-ap--- ?action ?provider )
            (increase (total-cost) 1)
        )
)
; (:action instantiate-intent-a-r--
;     :parameters ( ?action - action ?receiver - actor)
;     :precondition
;         (persistent-intent-a-r-- ?action ?receiver )
;         :effect         
;         (intent-a-r-- ?action ?receiver )
    
;     )
; (:action instantiate-intent--pr--
;     :parameters ( ?provider ?receiver - actor)
;     :precondition
;         (persistent-intent--pr-- ?provider ?receiver )
;         :effect         
;         (intent--pr-- ?provider ?receiver )
    
;     )
; (:action instantiate-intent-a--r-
;     :parameters ( ?action - action ?r - resource)
;     :precondition
;         (persistent-intent-a--r- ?action ?r )
;         :effect         
;         (intent-a--r- ?action ?r )
    
;     )
; (:action instantiate-intent--p-r-
;     :parameters ( ?provider - actor ?r - resource)
;     :precondition
;         (persistent-intent--p-r- ?provider ?r )
;         :effect         
;         (intent--p-r- ?provider ?r )
    
;     )
; (:action instantiate-intent---rr-
;     :parameters ( ?receiver - actor ?r - resource)
;     :precondition
;         (persistent-intent---rr- ?receiver ?r )
;         :effect         
;         (intent---rr- ?receiver ?r )
    
;     )
; (:action instantiate-intent-a---l
;     :parameters ( ?action - action ?l - location)
;     :precondition
;         (persistent-intent-a---l ?action ?l )
;         :effect         
;         (intent-a---l ?action ?l )
; )
; (:action instantiate-intent--p--l
;     :parameters ( ?p - actor ?l - location)
;     :precondition
;         (persistent-intent--p--l ?p ?l )
;         :effect         
;         (intent--p--l ?p ?l )
; )
; (:action instantiate-intent---r-l
;     :parameters ( ?r - actor ?l - location)
;     :precondition
;         (persistent-intent---r-l ?r ?l )
;         :effect         
;         (intent---r-l ?r ?l )
; )
; (:action instantiate-intent----rl
;     :parameters ( ?r - resource ?l - location)
;     :precondition
;         (persistent-intent----rl ?r ?l )
;         :effect         
;         (intent----rl ?r ?l )
; )
; (:action instantiate-intent-a----
;     :parameters ( ?action - action)
;     :precondition
;         (persistent-intent-a---- ?action )
;         :effect         
;         (intent-a---- ?action )
    
;     )
; (:action instantiate-intent--p--- 
;     :parameters (?provider - actor)
;     :precondition
;         (persistent-intent--p--- ?provider )
;         :effect         
;         (intent--p--- ?provider )
;     )
; (:action instantiate-intent---r-- 
;     :parameters (?receiver - actor)
;     :precondition
;         (persistent-intent---r-- ?receiver )
;         :effect         
;         (intent---r-- ?receiver )
    
;     )
; (:action instantiate-intent----r-
;     :parameters ( ?r - resource)
;     :precondition
;         (persistent-intent----r- ?r )
;         :effect         
;         (intent----r- ?r)
    
;     )
; (:action instantiate-intent-----l 
;     :parameters (?l - location)
;     :precondition
;         (persistent-intent-----l ?l)
;     :effect         
;         (intent-----l ?l)
; )


; careful: - incurs high complexity
; To limit the problem, the travel intent is deleted as a result of the action
(:action recipe-travel-to-location
    :parameters (?traveller - actor ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent-apr-l travel ?traveller ?traveller ?toLocation)
        (or 
            (currentLocation ?traveller ?fromLocation)
            (intent-apr-l arrive ?traveller ?traveller ?fromLocation)
        )
    )
    :effect (and 
        (intent-apr-l leave ?traveller ?traveller ?fromLocation)
        (intent-apr-l arrive ?traveller ?traveller ?toLocation)
        (not(intent-apr-l travel ?traveller ?traveller ?toLocation))
        (increase (total-cost) 1)
    )
)


(:action recipe-travel-unrestricted
    :parameters (?traveller - actor ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent-apr-- travel ?traveller ?traveller)
        (or 
            (currentLocation ?traveller ?fromLocation)
            (intent-apr-l arrive ?traveller ?traveller ?fromLocation)
        )        
    )
    :effect (and 
        (intent-apr-l leave ?traveller ?traveller ?fromLocation)
        (intent-apr-l arrive ?traveller ?traveller ?toLocation)
        (not (intent-apr-- travel ?traveller ?traveller))
        (increase (total-cost) 1)
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (:action recipe-get-vehicle
;     :parameters (?driver - actor  ?vehicle - vehicle ?location - location)
;     :precondition (and 
;         (isVehicle ?vehicle)
;         (currentLocation ?driver ?location)
;         (custodian ?vehicle ?driver)
;     )
;     :effect (and 
;         (intent use ?driver ?driver ?vehicle ?location)
;         (increase (total-cost) 1)
;     )
; )

(:action recipe-drive
    :parameters (?driver - actor ?car - vehicle ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (isVehicle ?car)
        (using ?driver ?car)
        (intent-apr-l leave ?driver ?driver ?fromLocation)
        (intent-apr-l arrive ?driver ?driver ?toLocation)
    )
    :effect (and 
        (intent move ?driver ?driver ?car ?toLocation)
        (not (intent-apr-l leave ?driver ?driver ?fromLocation))
        (not (intent-apr-l arrive ?driver ?driver ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action recipe-taxi
    :parameters (?driver ?passenger - actor  ?car - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?driver ?passenger))
        (intent-ap-r- deliver-taxi-service ?driver ?car) 
        (intent-apr-l leave ?passenger ?passenger ?fromLocation)
        (intent-apr-l arrive ?passenger ?passenger ?toLocation)
    )
    :effect (and 
        (when (not(currentLocation ?driver ?fromLocation))
            (forall (?dl - location)
                (when (currentLocation ?driver ?dl)
                    (intent-apr-l travel ?driver ?driver ?fromLocation)
                )
            )
        )
        (intent use ?driver ?driver ?car ?fromLocation)
        (intent mount ?driver ?passenger ?car ?fromLocation)
        (intent move ?driver ?driver ?car ?toLocation)
        (intent dismount ?driver ?passenger ?car ?toLocation)
        (not (intent-ap-r- deliver-taxi-service ?driver ?car) )
        (not (intent-apr-l leave ?passenger ?passenger ?fromLocation))
        (not (intent-apr-l arrive ?passenger ?passenger ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action recipe-transport
    :parameters (?transporter ?consignor ?consignee - actor  ?truck ?consignment - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?consignor ?consignee))
        (not (= ?consignor ?transporter))
        (not (= ?transporter ?consignee))
        (isVehicle ?truck)
        (mayContainResources ?truck)
        (or 
            (intent-ap-r- deliver-transport-service ?transporter ?truck)
            (intent-ap--- deliver-transport-service ?transporter)
        )
        (intent-ap-rl transfer-custody ?consignor ?consignment ?fromLocation )
        (intent-a-rrl transfer-custody ?consignee ?consignment ?toLocation )
    )
    :effect (and 
        (when (not(currentLocation ?transporter ?fromLocation))
            (forall (?dl - location)
                (when (currentLocation ?transporter ?dl)
                    (intent-apr-l travel ?transporter ?transporter ?fromLocation)
                )
            )
        )
        (intent transfer-custody ?consignor ?transporter ?consignment ?fromLocation)
        (intent use ?transporter ?transporter ?truck ?fromLocation)
        (intent move ?transporter ?transporter ?truck ?toLocation)
        (intent transfer-custody ?transporter ?consignee ?consignment ?toLocation)
        (not (intent-ap-r- deliver-transport-service ?transporter ?truck))
        (not (intent-ap--- deliver-transport-service ?transporter))
        (not (intent-ap-rl transfer-custody ?consignor ?consignment ?fromLocation ))
        (not (intent-a-rrl transfer-custody ?consignee ?consignment ?toLocation ))
        (increase (total-cost) 1)
    )
)

(:action recipe-borrow
    :parameters (?lender ?borrower - actor ?resource - resource ?location - location)
    :precondition (and 
        (primaryAccountable ?resource ?lender)
        (not (= ?lender ?borrower))
        (or
            (intent-ap-r- lend ?lender ?resource)
            (intent-ap-rl lend ?lender ?resource ?location)
            (intent lend ?lender ?borrower ?resource ?location)
        )
        (or
            (exists (?useLocation - location )
                (intent use ?borrower ?borrower ?resource ?useLocation) ;todo: match via resource class, not resource
            )
            (intent-aprr- use ?borrower ?borrower ?resource)
        )
    )
    :effect (and
        (when (not(currentLocation ?borrower ?location))
            (forall (?dl - location)
                (when (currentLocation ?borrower ?dl)
                    (intent-apr-l travel ?borrower ?borrower ?location)
                )
            )
        )
        (when (not(currentLocation ?borrower ?location))
            (forall (?dl - location)
                (when (currentLocation ?borrower ?dl)
                    (intent-apr-- travel ?borrower ?borrower )
                )
            )
        )
        (intent transfer-custody ?lender ?borrower ?resource ?location)
        (intent use ?borrower ?borrower ?resource ?location )
        (intent transfer-custody ?borrower ?lender ?resource ?location)
        (not(intent-ap-r- lend ?lender ?resource))
        (not(intent-ap-rl lend ?lender ?resource ?location))
        (not(intent lend ?lender ?borrower ?resource ?location))
        (increase (total-cost) 1)
    )
)

(:action recipe-send-and-transfer
    :parameters (?sender ?receiver - actor ?resource - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?sender ?receiver))
        (primaryAccountable ?resource ?sender)
        (intent-ap-rl send-and-transfer ?sender ?resource ?fromLocation)
        (intent-a-rrl send-and-transfer ?receiver ?resource ?toLocation)
    )    
    :effect (and
        (intent transfer-all-rights ?sender ?receiver ?resource ?fromLocation)
        (intent-ap-rl transfer-custody ?sender ?resource ?fromLocation)
        (intent-a-rrl transfer-custody ?receiver ?resource ?toLocation)
        (not(intent-ap-rl send-and-transfer ?sender ?resource ?fromLocation))
        (not(intent-a-rrl send-and-transfer ?receiver ?resource ?toLocation))
        (increase (total-cost) 1)
    )
)   


(:action move 
    :parameters (?a - actor ?r - resource ?fromLocation ?toLocation - location)
    :precondition ( and
        (not (isPassive ?a))
        (currentLocation ?r ?fromLocation)
        (currentLocation ?a ?fromLocation)
        (custodian ?r ?a)
        (commitment move ?a ?a ?r ?toLocation)
        (or
            (isCarryable ?r) ; actor carries it
            (and 
                (isVehicle ?r) ; actor drives it
                (using ?a ?r) ; actor uses it
            )
        )
    )
    :effect ( and
        (not (currentLocation ?r ?fromLocation))
        (not (currentLocation ?a ?fromLocation))
        (currentLocation ?r ?toLocation)
        (currentLocation ?a ?toLocation)
        (fulfillment move ?a ?a ?r ?toLocation)
        (not (commitment move ?a ?a ?r ?toLocation))
        (forall (?t - thing )
            (when 
                (containedIn ?t ?r)
                (and 
                    (currentLocation ?t ?toLocation)
                    (not (currentLocation ?t ?fromLocation))
                )
            )
        )
    )
)

(:action put-into
    :parameters (?a - actor ?r ?rContainer - resource)
    :precondition (and 
        (not (isPassive ?a))
        (custodian ?r ?a)
        (custodian ?rcontainer ?a)
        (mayContainResources ?rContainer)
        (exists (?l - location ) 
            (and
                (currentLocation ?r ?l)
                (currentLocation ?rContainer ?l)
            )
        )
        (not (exists (?otherContainer - resource) (containedIn ?r ?rContainer)))
    )
    :effect (and 
        (containedIn ?r ?rContainer)
    )
)


(:action take-out-of
    :parameters (?a - actor ?r ?rContainer - resource)
    :precondition (and
        (not (isPassive ?a))
        (containedIn ?r ?rContainer)
        (custodian ?rcontainer ?a)
    )
    :effect 
        (and
            (not (containedIn ?r ?rContainer))
        )
)


(:action mount
    :parameters (?driver ?passenger - actor ?vehicle - resource ?l - location)
    :precondition (and 
        (isVehicle ?vehicle)
        (not (isPassive ?driver))
        (not (isPassive ?passenger))
        (using ?driver ?vehicle)
        (mayContainActors ?vehicle)
        (commitment mount ?driver ?passenger ?vehicle ?l)            
        (currentLocation ?driver ?l)
        (currentLocation ?vehicle ?l)
        (currentLocation ?passenger ?l)
        (not (exists (?otherContainer - resource) (containedIn ?passenger ?vehicle)))
        (not 
            (exists (?res - resource )
                (and  
                    (custodian ?res ?passenger)
                    (not (isCarryable ?res))
                )
            )
        )
    )
    :effect (and 
        (containedIn ?passenger ?vehicle)
        (isPassive ?passenger)
        (fulfillment mount ?driver ?passenger ?vehicle ?l)           
        (not (commitment mount ?driver ?passenger ?vehicle ?l)) 
    )
)

(:action dismount
    :parameters (?driver ?passenger - actor ?vehicle - resource ?l - location)
    :precondition (and 
        (isVehicle ?vehicle)
        (not (isPassive ?driver))
        (custodian ?vehicle ?driver)
        (containedIn ?passenger ?vehicle)
        (currentLocation ?driver ?l)
        (currentLocation ?vehicle ?l)
        (currentLocation ?passenger ?l)
        (commitment dismount ?driver ?passenger ?vehicle ?l)
    )
    :effect 
        (and
            (not (containedIn ?passenger ?vehicle))
            (not (isPassive ?passenger))
            (fulfillment dismount ?driver ?passenger ?vehicle ?l)
            (not (commitment dismount ?driver ?passenger ?vehicle ?l))
        )
)

(:action begin-use
    :parameters (?a - actor ?r - resource)
    :precondition ( and
        (exists (?l - location) 
            (and
                (currentLocation ?r ?l)
                (currentLocation ?a ?l)
                (commitment use ?a ?a ?r ?l)
            )
        )
        (not (isPassive ?a))
        (custodian ?r ?a)
        (not (exists(?a2 - actor) (using ?a2 ?r)))
    )
    :effect (and
        (using ?a ?r)
        (fulfillment use ?a ?a ?r ?l)
    )
)


(:action end-use
    :parameters (?a - actor ?r - resource)
    :precondition 
        (and 
            (using ?a ?r)
            (not (isPassive ?a))
        )
    :effect 
        (and
            (not(using ?a ?r))
            (forall (?l - location)
                (when 
                    (commitment use ?a ?a ?r ?l)
                    (not(commitment use ?a ?a ?r ?l))
                )
            )
        )
)

(:action transfer-custody
    :parameters (?provider ?receiver - actor ?r - resource ?l - location)
    :precondition (and
        (not (isPassive ?provider))
        (not (isPassive ?receiver))
        (custodian ?r ?provider)
        (not (= ?provider ?receiver))
        (currentLocation ?provider ?l) 
        (currentLocation ?receiver ?l)
        (currentLocation ?r ?l)
        (commitment transfer-custody ?provider ?receiver ?r ?l) 
        (not (exists (?container - resource) (containedIn ?r ?container)))
    )
    :effect(and
        (not (custodian ?r ?provider))
        (custodian ?r ?receiver)
        (fulfillment transfer-custody ?provider ?receiver ?r ?l) 
        (not (commitment transfer-custody ?provider ?receiver ?r ?l) )
    )
)

(:action transfer-all-rights
    :parameters (?provider ?receiver - actor ?r - resource ?l - location)
    :precondition 
        ( and 
            (primaryAccountable ?r ?provider)
            (not (isPassive ?provider))
            (not (isPassive ?receiver)) ;questionable
            (currentLocation ?provider ?l)
            (commitment transfer-all-rights ?provider ?receiver ?r ?l) 
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (fulfillment transfer-all-rights ?provider ?receiver ?r ?l) 
            (not (commitment transfer-all-rights ?provider ?receiver ?r ?l) )
        )
)

(:action transfer
    :parameters (?provider - actor ?receiver - actor ?r - resource ?l - location)
    :precondition 
        ( and 
            (not (isPassive ?provider))
            (not (isPassive ?receiver))
            (custodian ?r ?provider)
            (primaryAccountable ?r ?provider)
            (currentLocation ?provider ?l) 
            (currentLocation ?receiver ?l)
            (currentLocation ?r ?l)
            (commitment transfer ?provider ?receiver ?r ?l) 
            (not (exists (?container - resource) (containedIn ?r ?container)))
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (not (custodian ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (custodian ?r ?receiver)            
            (fulfillment transfer ?provider ?receiver ?r ?l) 
            (not (commitment transfer ?provider ?receiver ?r ?l) )
        )
)

)
