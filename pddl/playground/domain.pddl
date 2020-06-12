

(define (domain valueflows)


(:requirements :adl :action-costs)

(:types 
    thing
    resource - thing 
    actor - thing
    vehicle - resource
    truck - vehicle
    car - vehicle
    resourceClassType
    location
    action
    vehicleClassType - resourceClassType
    serviceClassType - resourceClassType
)

(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use send-and-transfer deliver-service lend leave arrive drive travel - action
    TransportServiceClass - serviceClassType
    TaxiServiceClass - serviceClassType
    TruckClass - vehicleClassType
    CarClass - vehicleClassType
)

(:functions (total-cost - numeric))

(:predicates 
    (currentLocation ?t - thing ?l - location) ; t is at location l
    (resourceClassification ?r - resource ?c - resourceClassType )
    (custodian ?r - resource ?a - actor ) ; a is currently in custody of r
    (primaryAccountable ?r - resource ?a - actor) ; a is the owner of r

    (intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    (intent-apr--c ?action - action ?provider ?receiver - actor ?c - resourceClassType)
    (intent-ap-r-c ?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    (intent-apr-lc ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)    
    (intent-ap--lc ?action - action ?provider - actor ?l - location ?c - resourceClassType)
    (intent-a-r-lc ?action - action ?receiver - actor ?l - location ?c - resourceClassType)
    (intent-apr--c ?action - action ?provider ?receiver - actor  ?c - resourceClassType)
    (intent-ap---c ?action - action ?provider - actor ?c - resourceClassType)
    (intent-ap---c ?action - action ?provider - actor ?c - resourceClassType)
    (intent-aprrl- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (intent-aprr-- ?action - action ?provider ?receiver - actor ?r - resource)
    (intent-apr-l- ?action - action ?provider ?receiver - actor ?l - location)    
    (intent-ap-rl- ?action - action ?provider - actor ?r - resource ?l - location)
    (intent-a-rrl- ?action - action ?receiver - actor ?r - resource ?l - location)
    (intent-apr--- ?action - action ?provider ?receiver - actor )
    (intent-ap-r-- ?action - action ?provider - actor ?r - resource)
    (intent-ap---- ?action - action ?provider - actor)



    (persistent-intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    (persistent-intent-apr--c ?action - action ?provider ?receiver - actor ?c - resourceClassType)
    (persistent-intent-ap-r-c ?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    (persistent-intent-apr-lc ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)    
    (persistent-intent-ap--lc ?action - action ?provider - actor ?l - location ?c - resourceClassType)
    (persistent-intent-a-r-lc ?action - action ?receiver - actor ?l - location ?c - resourceClassType)
    (persistent-intent-apr--c ?action - action ?provider ?receiver - actor ?c - resourceClassType)
    (persistent-intent-ap---c ?action - action ?provider - actor ?c - resourceClassType)
    (persistent-intent-ap---c ?action - action ?provider - actor ?c - resourceClassType)
    (persistent-intent-aprrl- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (persistent-intent-aprr-- ?action - action ?provider ?receiver - actor ?r - resource )
    (persistent-intent-apr-l- ?action - action ?provider ?receiver - actor ?l - location )    
    (persistent-intent-ap-rl- ?action - action ?provider - actor ?r - resource ?l - location )
    (persistent-intent-a-rrl- ?action - action ?receiver - actor ?r - resource ?l - location )
    (persistent-intent-apr--- ?action - action ?provider ?receiver - actor )
    (persistent-intent-ap-r-- ?action - action ?provider - actor ?r - resource )
    (persistent-intent-ap---- ?action - action ?provider - actor )


    
    (commitment-r- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (commitment--c ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)
    (fulfillment-r- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (fulfillment--c ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)
    (using ?a - actor ?r - resource) ; a is using r
    (isCarryable ?r - resource) ; an actor can move the resource
    (isVehicle ?r - resource) ; r is a vehicle
    (isPassive ?a - actor) ; actor cannot be in the provider/receiver role
    (mayContainResources ?r - resource) ; a truck, for example
    (mayContainActors ?a - actor) ; a means of person transport
    (containedIn ?rinside - thing ?rcontainer - resource) ; rinside is inside rcontainer
)

; commit: turn an intent into a commitment

(:action commit--c 
    :parameters (?action - action ?provider ?receiver - actor ?location - location ?c - resourceClassType)
    :precondition 
        (intent-apr-lc ?action ?provider ?receiver ?location ?c)
    :effect (and
        (commitment--c ?action ?provider ?receiver ?location ?c)
        (not (intent-apr-lc ?action ?provider ?receiver ?location ?c))
    )
)

(:action commit-r- 
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition 
        (intent-aprrl- ?action ?provider ?receiver ?resource ?location)
    :effect (and
        (commitment-r- ?action ?provider ?receiver ?resource ?location)
        (not (intent-aprrl- ?action ?provider ?receiver ?resource ?location))
    )
)


; create an intent from an persistent-intent

(:action instantiate-intent
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    :precondition
        (persistent-intent ?action ?provider ?receiver ?r ?l ?c)
    :effect         
        (and
            (intent ?action ?provider ?receiver ?r ?l ?c)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-apr--c
    :parameters ( ?action - action ?provider ?receiver - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-apr--c ?action ?provider ?receiver ?c )
    :effect         
        (and
            (intent-apr--c ?action ?provider ?receiver ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap-r-c
    :parameters (?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    :precondition
        (persistent-intent-ap-r-c ?action ?provider ?r ?c)
    :effect         
        (and
            (intent-ap-r-c ?action ?provider ?r ?c)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-apr-lc
    :parameters ( ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType )    
    :precondition
        (persistent-intent-apr-lc ?action ?provider ?receiver ?l ?c )
    :effect         
        (and
            (intent-apr-lc ?action ?provider ?receiver ?l ?c )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-ap--lc
    :parameters ( ?action - action ?provider - actor ?l - location ?c - resourceClassType )
    :precondition
        (persistent-intent-ap--lc ?action ?provider ?l ?c )
        :effect         
        (and
            (intent-ap--lc ?action ?provider ?l ?c )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-a-r-lc
    :parameters ( ?action - action ?receiver - actor ?l - location ?c - resourceClassType )
    :precondition
        (persistent-intent-a-r-lc ?action ?receiver ?l ?c )
    :effect         
        (and
            (intent-a-r-lc ?action ?receiver ?l ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-apr--c
    :parameters ( ?action - action ?provider ?receiver - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-apr--c ?action ?provider ?receiver ?c )
        :effect         
        (and
            (intent-apr--c ?action ?provider ?receiver ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap---c
    :parameters ( ?action - action ?provider - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-ap---c ?action ?provider ?c )
        :effect         
        (and
            (intent-ap---c ?action ?provider ?c )
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-ap---c
    :parameters ( ?action - action ?provider - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-ap---c ?action ?provider ?c )
        :effect         
        (and
            (intent-ap---c ?action ?provider ?c )
            (increase (total-cost) 1)
        )
)


; no class

(:action instantiate-intent-aprrl-
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-aprrl- ?action ?provider ?receiver ?r ?l)
    :effect         
        (and
            (intent-aprrl- ?action ?provider ?receiver ?r ?l)
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-aprr--
    :parameters ( ?action - action ?provider ?receiver - actor ?r - resource)
    :precondition
        (persistent-intent-aprr-- ?action ?provider ?receiver ?r )
    :effect         
        (and
            (intent-aprr-- ?action ?provider ?receiver ?r )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-apr-l-
    :parameters ( ?action - action ?provider ?receiver - actor ?l - location)    
    :precondition
        (persistent-intent-apr-l- ?action ?provider ?receiver ?l )
    :effect         
        (and
            (intent-apr-l- ?action ?provider ?receiver ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-ap-rl-
    :parameters ( ?action - action ?provider - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-ap-rl- ?action ?provider ?r ?l )
        :effect         
        (and
            (intent-ap-rl- ?action ?provider ?r ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-a-rrl-
    :parameters ( ?action - action ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-a-rrl- ?action ?receiver ?r ?l )
    :effect         
        (and
            (intent-a-rrl- ?action ?receiver ?r ?l )
            (increase (total-cost) 1)
        )
    )

(:action instantiate-intent-apr---
    :parameters ( ?action - action ?provider ?receiver - actor)
    :precondition
        (persistent-intent-apr--- ?action ?provider ?receiver)
        :effect         
        (and
            (intent-apr--- ?action ?provider ?receiver)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap-r--
    :parameters ( ?action - action ?provider - actor ?r - resource)
    :precondition
        (persistent-intent-ap-r-- ?action ?provider ?r )
        :effect         
        (and
            (intent-ap-r-- ?action ?provider ?r )
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-ap----
    :parameters ( ?action - action ?provider - actor)
    :precondition
        (persistent-intent-ap---- ?action ?provider )
        :effect         
        (and
            (intent-ap---- ?action ?provider )
            (increase (total-cost) 1)
        )
)


; match-resource: turn an intent with a resourceClassifiedAs into an intent with a resource of that class
(:action match-resource-a-r-lc
    :parameters (?action - action ?receiver - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-a-r-lc ?action ?receiver ?l ?c)
    )
    :effect (and
        (intent-a-rrl- ?action ?receiver ?resource ?l)
        (not (intent-a-r-lc ?action ?receiver ?l ?c))
    )
)

(:action match-resource-ap--lc
    :parameters (?action - action ?provider - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-ap--lc ?action ?provider ?l ?c )
    )
    :effect (and
        (intent-ap-rl- ?action ?provider ?resource ?l)
        (not (intent-ap--lc ?action ?provider ?l ?c ))
    )
)

(:action match-resource-apr-lc
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-apr-lc ?action ?provider ?receiver ?l ?c)    
    )
    :effect (and
        (intent-aprrl- ?action ?provider ?receiver ?resource ?l)    
        (not (intent-apr-lc ?action ?provider ?receiver ?l ?c))
    )
)

(:action match-resource-apr--c
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-apr--c ?action ?provider ?receiver ?c)
    )
    :effect (and
        (intent-aprr-- ?action ?provider ?receiver ?resource)    
        (not (intent-apr--c ?action ?provider ?receiver ?c))
    )
)

(:action match-resource-ap---c
    :parameters (?action - action ?provider - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-ap---c ?action ?provider ?c)
    )
    :effect (and
        (intent-ap-r-- ?action ?provider ?resource)
        (not (intent-ap---c ?action ?provider ?c))
    )
)

; careful: - incurs high complexity
; To limit the problem, the travel intent is deleted as a result of the action
(:action recipe-travel-to-location
    :parameters (?traveller - actor ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent-apr-l- travel ?traveller ?traveller ?toLocation)
        (or 
            (currentLocation ?traveller ?fromLocation)
            (intent-apr-l- arrive ?traveller ?traveller ?fromLocation)
        )
    )
    :effect (and 
        (intent-apr-l- leave ?traveller ?traveller ?fromLocation)
        (intent-apr-l- arrive ?traveller ?traveller ?toLocation)
        (not(intent-apr-l- travel ?traveller ?traveller ?toLocation))
        (increase (total-cost) 1)
    )
)


(:action recipe-travel-unrestricted
    :parameters (?traveller - actor ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent-apr--- travel ?traveller ?traveller)
        (or 
            (currentLocation ?traveller ?fromLocation)
            (intent-apr-l- arrive ?traveller ?traveller ?fromLocation)
        )        
    )
    :effect (and 
        (intent-apr-l- leave ?traveller ?traveller ?fromLocation)
        (intent-apr-l- arrive ?traveller ?traveller ?toLocation)
        (not (intent-apr--- travel ?traveller ?traveller))
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
        (intent-apr-l- leave ?driver ?driver ?fromLocation)
        (intent-apr-l- arrive ?driver ?driver ?toLocation)
    )
    :effect (and 
        (intent-aprrl- move ?driver ?driver ?car ?toLocation)
        (not (intent-apr-l- leave ?driver ?driver ?fromLocation))
        (not (intent-apr-l- arrive ?driver ?driver ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action recipe-taxi
    :parameters (?driver ?passenger - actor  ?car - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?driver ?passenger))
        (or 
            (intent-ap---c deliver-service ?driver TaxiServiceClass)   
            (intent-ap-r-c deliver-service ?driver ?car TaxiServiceClass) 
        )
        (intent-apr-l- leave ?passenger ?passenger ?fromLocation)
        (intent-apr-l- arrive ?passenger ?passenger ?toLocation)
    )
    :effect (and 
        (when (not(currentLocation ?driver ?fromLocation))
            (forall (?dl - location)
                (when (currentLocation ?driver ?dl)
                    (intent-apr-l- travel ?driver ?driver ?fromLocation)
                )
            )
        )
        (intent-aprrl- use ?driver ?driver ?car ?fromLocation)
        (intent-aprrl- mount ?driver ?passenger ?car ?fromLocation)
        (intent-aprrl- move ?driver ?driver ?car ?toLocation)
        (intent-aprrl- dismount ?driver ?passenger ?car ?toLocation)
        (not (intent-ap-r-c deliver-service ?driver ?car TaxiServiceClass) )
        (not (intent-ap---c deliver-service ?driver TaxiServiceClass) )
        (not (intent-apr-l- leave ?passenger ?passenger ?fromLocation))
        (not (intent-apr-l- arrive ?passenger ?passenger ?toLocation))
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
        ; no need to check for another transporter instantiating 
        ; the same recipe: the intents are removed, so it cannot happen
        (isVehicle ?truck)
        (mayContainResources ?truck)
        (or 
            (intent-ap-r-c deliver-service ?transporter ?truck TransportServiceClass)
            (intent-ap---c deliver-service ?transporter TransportServiceClass)
        )
        (intent-ap-rl- transfer-custody ?consignor ?consignment ?fromLocation )
        (intent-a-rrl- transfer-custody ?consignee ?consignment ?toLocation )
    )
    :effect (and 
        (when (not(currentLocation ?transporter ?fromLocation))
            (forall (?dl - location)
                (when (currentLocation ?transporter ?dl)
                    (intent-apr-l- travel ?transporter ?transporter ?fromLocation)
                )
            )
        )
        (intent-aprrl- transfer-custody ?consignor ?transporter ?consignment ?fromLocation)
        (intent-aprrl- use ?transporter ?transporter ?truck ?fromLocation)
        (intent-aprrl- move ?transporter ?transporter ?truck ?toLocation)
        (intent-aprrl- transfer-custody ?transporter ?consignee ?consignment ?toLocation)
        (not (intent-ap-r-c deliver-service ?transporter ?truck TransportServiceClass))
        (not (intent-ap---c deliver-service ?transporter TransportServiceClass))
        (not (intent-ap-rl- transfer-custody ?consignor ?consignment ?fromLocation ))
        (not (intent-a-rrl- transfer-custody ?consignee ?consignment ?toLocation ))
        (increase (total-cost) 1)
    )
)

(:action recipe-borrow
    :parameters (?lender ?borrower - actor ?resource - resource ?location - location)
    :precondition (and 
        (primaryAccountable ?resource ?lender)
        (not (= ?lender ?borrower))
        (or
            (intent-ap-r-- lend ?lender ?resource)
            (intent-ap-rl- lend ?lender ?resource ?location)
            (intent-aprrl- lend ?lender ?borrower ?resource ?location)
        )
        (or
            (exists (?useLocation - location )
                (intent-aprrl- use ?borrower ?borrower ?resource ?useLocation) ;todo: match via resource class, not resource
            )
            (intent-aprr-- use ?borrower ?borrower ?resource)
        )
    )
    :effect (and
        (when (not(currentLocation ?borrower ?location))
            (forall (?dl - location)
                (when (currentLocation ?borrower ?dl)
                    (intent-apr-l- travel ?borrower ?borrower ?location)
                )
            )
        )
        (when (not(currentLocation ?borrower ?location))
            (forall (?dl - location)
                (when (currentLocation ?borrower ?dl)
                    (intent-apr--- travel ?borrower ?borrower )
                )
            )
        )
        (intent-aprrl- transfer-custody ?lender ?borrower ?resource ?location)
        (intent-aprrl- use ?borrower ?borrower ?resource ?location )
        (intent-aprrl- transfer-custody ?borrower ?lender ?resource ?location)
        (not(intent-ap-r-- lend ?lender ?resource))
        (not(intent-ap-rl- lend ?lender ?resource ?location))
        (not(intent-aprrl- lend ?lender ?borrower ?resource ?location))
        (increase (total-cost) 1)
    )
)

(:action recipe-send-and-transfer
    :parameters (?sender ?receiver - actor ?resource - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?sender ?receiver))
        (primaryAccountable ?resource ?sender)
        (intent-ap-rl- send-and-transfer ?sender ?resource ?fromLocation)
        (intent-a-rrl- send-and-transfer ?receiver ?resource ?toLocation)
    )    
    :effect (and
        (intent-aprrl- transfer-all-rights ?sender ?receiver ?resource ?fromLocation)
        (intent-ap-rl- transfer-custody ?sender ?resource ?fromLocation)
        (intent-a-rrl- transfer-custody ?receiver ?resource ?toLocation)
        (not(intent-ap-rl- send-and-transfer ?sender ?resource ?fromLocation))
        (not(intent-a-rrl- send-and-transfer ?receiver ?resource ?toLocation))
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
        (commitment-r- move ?a ?a ?r ?toLocation)
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
        (fulfillment-r- move ?a ?a ?r ?toLocation)
        (not (commitment-r- move ?a ?a ?r ?toLocation))
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
        (commitment-r- mount ?driver ?passenger ?vehicle ?l)            
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
        (fulfillment-r- mount ?driver ?passenger ?vehicle ?l)           
        (not (commitment-r- mount ?driver ?passenger ?vehicle ?l)) 
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
        (commitment-r- dismount ?driver ?passenger ?vehicle ?l)
    )
    :effect 
        (and
            (not (containedIn ?passenger ?vehicle))
            (not (isPassive ?passenger))
            (fulfillment-r- dismount ?driver ?passenger ?vehicle ?l)
            (not (commitment-r- dismount ?driver ?passenger ?vehicle ?l))
        )
)

(:action begin-use
    :parameters (?a - actor ?r - resource)
    :precondition ( and
        (exists (?l - location) 
            (and
                (currentLocation ?r ?l)
                (currentLocation ?a ?l)
                (commitment-r- use ?a ?a ?r ?l)
            )
        )
        (not (isPassive ?a))
        (custodian ?r ?a)
        (not (exists(?a2 - actor) (using ?a2 ?r)))
    )
    :effect (and
        (using ?a ?r)
        (fulfillment-r- use ?a ?a ?r ?l)
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
                    (commitment-r- use ?a ?a ?r ?l)
                    (not(commitment-r- use ?a ?a ?r ?l))
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
        (commitment-r- transfer-custody ?provider ?receiver ?r ?l) 
        (not (exists (?container - resource) (containedIn ?r ?container)))
    )
    :effect(and
        (not (custodian ?r ?provider))
        (custodian ?r ?receiver)
        (fulfillment-r- transfer-custody ?provider ?receiver ?r ?l) 
        (not (commitment-r- transfer-custody ?provider ?receiver ?r ?l) )
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
            (commitment-r- transfer-all-rights ?provider ?receiver ?r ?l) 
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (fulfillment-r- transfer-all-rights ?provider ?receiver ?r ?l) 
            (not (commitment-r- transfer-all-rights ?provider ?receiver ?r ?l) )
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
            (commitment-r- transfer ?provider ?receiver ?r ?l) 
            (not (exists (?container - resource) (containedIn ?r ?container)))
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (not (custodian ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (custodian ?r ?receiver)            
            (fulfillment-r- transfer ?provider ?receiver ?r ?l) 
            (not (commitment-r- transfer ?provider ?receiver ?r ?l) )
        )
)

)
