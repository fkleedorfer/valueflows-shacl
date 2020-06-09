

(define (domain valueflows)


(:requirements :strips :typing :adl )

(:types 
    thing
    role
    resource - thing 
    actor - thing 
    recipeResource - thing
    vehicle - resource
    truck - vehicle
    car - vehicle
    resourceClass
    location
    action
    recipeFlow
    recipeProcess
    recipeLocation 
)

; un-comment following line if constants are needed
(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use - action
    null - thing


    ; wikidataTransport - resourceClass
    ; rConsignment - recipeResource
    ; rVehicle - recipeResource
    ; rTransporter - role
    ; rContractee - role
    ; rMoveConsignment - recipeFlow
    ; rUseVehicle - recipeFlow
    ; rFromLocation - recipeLocation
    ; rToLocation - recipeLocation 
    ; (recipeFlow rMoveConsignment move rTransporter rContractee rConsignment rFromLocation rTolocation)
    ; (recipeFlow rMoveVehicle move rTransporter rContractee rVehicle rFromLocation rTolocation)
    ; (recipeFlow rUseVehicleAtFromLocation use rTransporter rTransporter rVehicle rFromLocation)
    ; (recipeFlow rUseVehicleAtToLocation use rTransporter rTransporter rVehicle rToLocation)
    ; (recipeFlow rDeliverTransportService deliver-service rTransporter rContractee wikidataTransport)
    ; (recipeInputOf rTransport rMoveVehicle )
    ; (recipeInputOf rTransport rUseVehicleAtFromLocation )
    ; (recipeOutputOf rTransport rUseVehicleAtToLocation )
    ; (recipeOutputOf rTransport rMoveConsignment )
    ; (recipeResultOf rTransport rDeliverTransportService)
)

(:predicates 
    (currentLocation ?t - thing ?l - location) ; t is at location l
    (resourceClassification ?r - resource ?c - resourceClass )
    (custodian ?r - resource ?a - actor ) ; a is currently in custody of r
    (primaryAccountable ?r - resource ?a - actor) ; a is the owner of r
    (intent ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (commitment ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (using ?a - actor ?r - resource) ; a is using r
    (isCarryable ?r - resource) ; an actor can move the resource
    (isVehicle ?r - resource) ; r is a vehicle
    (isPassive ?a - actor) ; actor cannot be in the provider/receiver role
    (mayContainResources ?r - resource) ; a truck, for example
    (mayContainActors ?a - actor) ; a means of person transport
    (containedIn ?rinside - thing ?rcontainer - resource) ; rinside is inside rcontainer
   ; (recipeFlow ?action - action ?provider - actor ?receiver - actor ?r - recipeResource)
)


;(:functions (total-cost))

(:action commit 
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition 
        (or 
            (intent ?action ?provider ?receiver ?resource ?location)
            (intent ?action ?provider ?receiver ?resource null)
            (and
                (intent ?action ?provider null ?resource ?location)
                (intent ?action null ?receiver ?resource ?location)
            )
            (and
                (intent ?action ?provider ?receiver ?resource null)
                (intent ?action ?provider ?receiver ?resource null)
            )
            (and
                (intent ?action ?provider ?receiver null ?location)
                (intent ?action ?provider ?receiver null ?location)
            )
            (and
                (intent ?action ?provider null ?resource ?location)
                (intent ?action null ?receiver ?resource ?location)
            )
            (and
                (intent ?action ?provider null ?resource null)
                (intent ?action null ?receiver null ?location)
            )
            (and
                (intent ?action ?provider null null ?location)
                (intent ?action null ?receiver ?resource null)
            )
            (and
                (intent ?action ?provider null ?resource null)
                (intent ?action null ?receiver null null)
            )
            (and
                (intent ?action ?provider null ?resource ?location)
                (intent ?action null ?receiver ?resource null)
            )
            (and
                (intent ?action ?provider null ?resource null)
                (intent ?action null ?receiver ?resource ?location)
            )
            (and
                (intent ?action ?provider null null null)
                (intent ?action null ?receiver ?resource ?location)
            )
            (and
                (intent ?action null ?receiver null null)
                (intent ?action ?provider null ?resource ?location)
            )
        )
    :effect 
        (commitment ?action ?provider ?receiver ?resource ?location)
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
    )
)

(:action dismount
    :parameters (?driver ?passenger - actor ?vehicle - resource ?l - location)
    :precondition (and 
        (isVehicle ?vehicle)
        (not (isPassive ?driver))
        (custodian ?vehicle ?driver)
        (containedIn ?passenger ?vehicle)
        (commitment dismount ?driver ?passenger ?vehicle ?l)
    )
    :effect 
        (and
            (not (containedIn ?passenger ?vehicle))
            (not (isPassive ?passenger))
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
    :effect (using ?a ?r)
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
        )
)

)
