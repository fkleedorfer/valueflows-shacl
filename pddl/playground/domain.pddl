

(define (domain valueflows)


(:requirements :strips :typing :adl )

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

; un-comment following line if constants are needed
(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use send-and-transfer deliver-taxi-service deliver-transport-service lend leave arrive drive travel - action
    null - thing
)

(:predicates 
    (currentLocation ?t - thing ?l - location) ; t is at location l
    (resourceClassification ?r - resource ?c - resourceClass )
    (custodian ?r - resource ?a - actor ) ; a is currently in custody of r
    (primaryAccountable ?r - resource ?a - actor) ; a is the owner of r
    (intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
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
    )
)

; not good - incurs high complexity
; (:action travel-recipe
;     :parameters (?traveller - actor ?fromLocation ?toLocation - location)
;     :precondition (and 
;         (not (= ?fromLocation ?toLocation))
;         (or
;             (intent travel ?traveller ?traveller null ?toLocation)
;             (intent travel ?traveller ?traveller null null)
;             (exists (?someCar - vehicle)
;                 (or
;                     (intent travel ?traveller ?traveller ?someCar null)
;                     (intent travel ?traveller ?traveller ?someCar ?toLocation)
;                 )
;             )
;         )
;         (or 
;             (currentLocation ?traveller ?fromLocation)
;             (exists (?someDriver - actor ?someCar - car)
;                 (commitment dismount ?someDriver ?traveller ?someCar ?fromLocation)    
;             )
;             (exists (?someCar - car)
;                 (commitment move ?traveller ?traveller ?someCar ?fromLocation)    
;             )
;         )
;     )
;     :effect (and 
;         (intent leave ?traveller ?traveller null ?fromLocation)
;         (intent arrive ?traveller ?traveller null ?toLocation)
;     )
; )

(:action drive-recipe
    :parameters (?driver - actor ?car - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent drive ?driver ?driver ?car null)
        (isVehicle ?car)
        (or
            (and 
                (intent leave ?driver ?driver null ?fromLocation)
                (intent arrive ?driver ?driver null ?toLocation)
            )
            (and 
                (intent leave ?driver ?driver ?car ?fromLocation)
                (intent arrive ?driver ?driver ?car ?toLocation)
            )
        )
    )
    :effect (and 
        (intent use ?driver ?driver ?car ?fromLocation)
        (intent move ?driver ?driver ?car ?toLocation)
    )
)

(:action taxi-recipe
    :parameters (?driver ?passenger - actor  ?car - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (intent deliver-taxi-service ?driver null ?car null) ;TODO or with null car
        (intent leave ?passenger ?passenger null ?fromLocation)
        (intent arrive ?passenger ?passenger null ?toLocation)
    )
    :effect (and 
        (forall (?driverLocation - location )
            (when
                (and
                    (currentLocation ?driver ?driverLocation)
                    (not (= ?driverLocation ?fromLocation))
                )
                (and
                    (intent drive ?driver ?driver ?car null)
                    (intent leave ?driver ?driver ?car ?driverLocation)
                    (intent arrive ?driver ?driver ?car ?fromLocation)
                )
            )
        )
        (intent use ?driver ?driver ?car ?fromLocation)
        (intent mount ?driver ?passenger ?car ?fromLocation)
        (intent move ?driver ?driver ?car ?toLocation)
        (intent dismount ?driver ?passenger ?car ?toLocation)
        (intent travel ?driver ?driver ?car null) ; intend to go back home
    )
)

(:action transport-recipe
    :parameters (?transporter ?consignor ?consignee - actor  ?truck ?consignment - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?consignor ?consignee))
        (not (= ?consignor ?transporter))
        (not (= ?transporter ?consignee))
        (isVehicle ?truck)
        (mayContainResources ?truck)
        (or 
            (intent deliver-transport-service ?transporter null ?truck null)
            (intent deliver-transport-service ?transporter null null null)
        )
        (intent transfer-custody ?consignor null ?consignment ?fromLocation )
        (intent transfer-custody null ?consignee ?consignment ?toLocation )
    )
    :effect (and 
        (forall (?transporterLocation - location )
            (when
                (and
                    (currentLocation ?transporter ?transporterLocation)
                    (not (= ?transporterLocation ?fromLocation))
                )
                (and
                    (intent drive ?transporter ?transporter ?truck null)
                    (intent leave ?transporter ?transporter ?truck ?transporterLocation)
                    (intent arrive ?transporter ?transporter ?truck ?fromLocation)
                )
            )
        )
        (intent transfer-custody ?consignor ?transporter ?consignment ?fromLocation)
        (intent use ?transporter ?transporter ?truck ?fromLocation)
        (intent move ?transporter ?transporter ?truck ?toLocation)
        (intent transfer-custody ?transporter ?consignee ?consignment ?toLocation)
    )
)

(:action borrow-recipe
    :parameters (?lender ?borrower - actor ?resource - resource ?location - location)
    :precondition (and 
        (primaryAccountable ?resource ?lender)
        (not (= ?lender ?borrower))
        (or
            (intent lend ?lender null ?resource null)
            (intent lend ?lender null ?resource ?location)
        )
        (or
            (exists (?useLocation - location )
                (intent use ?borrower ?borrower ?resource ?useLocation)
            )
            (intent use ?borrower ?borrower ?resource null)
        )
    )
    :effect (and
        (forall (?borrowerLocation - location )
            (when
                (and
                    (currentLocation ?borrower ?borrowerLocation)
                    (not (= ?borrowerLocation ?location))
                )
                (and
                    (intent leave ?borrower ?borrower null ?borrowerLocation)
                    (intent arrive ?borrower ?borrower null ?location)
                )
            )
        )
        (intent transfer-custody ?lender ?borrower ?resource ?location)
        (intent use ?borrower ?borrower ?resource ?location )
        (intent transfer-custody ?borrower ?lender ?resource ?location)
    )
)

(:action send-and-transfer-recipe
    :parameters (?sender ?receiver - actor ?resource - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?sender ?receiver))
        (primaryAccountable ?resource ?sender)
        (intent send-and-transfer ?sender null ?resource ?fromLocation)
        (intent send-and-transfer null ?receiver ?resource ?toLocation)
    )    
    :effect (and
        (intent transfer-all-rights ?sender ?receiver ?resource ?fromLocation)
        (intent transfer-custody ?sender null ?resource ?fromLocation)
        (intent transfer-custody null ?receiver ?resource ?toLocation)
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
        )
)

)
