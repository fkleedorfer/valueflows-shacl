

(define (domain valueflows)


(:requirements :strips :typing )

(:types 
    thing
    resource - thing 
    actor - thing 
    resourceClass
    location
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (currentLocation ?t - thing ?l - location)
    (resourceClassification ?r - resource ?c - resourceClass )
    (transporter ?a - actor)
    (custodian ?r - resource ?a - actor )
    (primaryAccountable ?r - resource ?a - actor)
    (stationary ?t - thing) ; things that won't move
)


;(:functions )


(:action move 
    :parameters (?r - resource ?a - actor ?fromLocation - location ?toLocation - location)
    :precondition ( and
        (transporter ?a )
        (currentLocation ?r ?fromLocation)
        (currentLocation ?a ?fromLocation)
        (custodian ?r ?a)
        (not(stationary ?a))
        (not(stationary ?r))
    )
    :effect ( and
        (not (currentLocation ?r ?fromLocation))
        (not (currentLocation ?a ?fromLocation))
        (currentLocation ?r ?toLocation)
        (currentLocation ?a ?toLocation)
    )
)

(:action goto
    :parameters (?a - actor ?fromLocation - location ?toLocation - location)
    :precondition 
        (and
            (currentLocation ?a ?fromLocation)
            (not(stationary ?a))
        )
    :effect
        (and
            (not (currentLocation ?a ?fromLocation))
            (currentLocation ?a ?toLocation)
        )
)

(:action transfer-custody
    :parameters (?provider - actor ?receiver - actor ?r - resource ?l - location)
    :precondition (and
        (custodian ?r ?provider)
        (currentLocation ?provider ?l) 
        (currentLocation ?receiver ?l)
        (currentLocation ?r ?l)
        )
    :effect(and
        (not (custodian ?r ?provider))
        (custodian ?r ?receiver)
    )
)

(:action transfer-all-rights
    :parameters (?provider - actor ?receiver - actor ?r - resource)
    :precondition 
        ( and 
            (primaryAccountable ?r ?provider)
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (primaryAccountable ?r ?receiver)
        )
)

(:action transfer
    :parameters (?provider - actor ?receiver - actor ?r - resource)
    :precondition 
        ( and 
            (custodian ?r ?provider)
            (primaryAccountable ?r ?provider)
            (currentLocation ?provider ?l) 
            (currentLocation ?receiver ?l)
            (currentLocation ?r ?l)
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
