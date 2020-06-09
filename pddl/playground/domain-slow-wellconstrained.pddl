

(define (domain valueflows)


(:requirements :strips :typing :adl )

(:types 
    thing
    resource - thing 
    actor - thing 
    recipeResource - thing
    vehicle - resource
    truck - vehicle
    car - vehicle
    resourceClass
    location
    action
    
    recipe
    recipeRole
    recipe1role1resource - recipe
    recipe2roles1resource - recipe
    recipe2roles2resources - recipe
    recipe3roles1resource - recipe
    recipe3roles2resources - recipe
    recipeFlow
    recipeProcess
    recipeLocation 
)

; un-comment following line if constants are needed
(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use - action
    null - thing
    role1 role2 role3 - recipeRole
    resource1 resource2 - recipeResource
    locationOfRole1 locationOfRole2 locationOfRole3 locationOfResource1 locationOfResource2 otherLocation - recipeLocation
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
    
    (recipeClauseOf ?flow - recipeFlow ?recipe - recipe )
    (flowAction ?flow - recipeFlow ?action - action)
    (flowProvider ?flow - recipeFlow ?provider - recipeRole)
    (flowReceiver ?flow - recipeFlow ?receiver - recipeRole)
    (flowResource ?flow - recipeFlow ?resource - recipeResource)
    (flowLocation ?flow - recipeFlow ?location - recipeLocation)
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





(:action instantiate-recipe1role1resource
    :parameters (?recipe - recipe1role1resource ?role1 - actor ?resource1 - resource)
    :precondition (and 
        (recipeClauseOf ?flow ?recipe)
        (flowAction ?flow ?action)
        (flowProvider ?flow role1)
        (flowReceiver ?flow role1)
        (flowResource ?flow resource1)
        (or
            (and  
                (flowLocation ?flow locationOfRole1)
                (currentLocation ?role1 ?location)
            )
            (and  
                (flowLocation ?flow locationOfResource1)
                (currentLocation ?resource1 ?location)
            )
        )    
    )
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (and 
                    (recipeClauseOf ?flow ?recipe)
                    (flowProvider ?flow role1)
                    (flowReceiver ?flow role1)
                    (flowResource ?flow resource1)
                )
                (forall (?action - action)
                    (when 
                        (flowAction ?flow ?action)
                        (forall (?location - location) 
                            (when
                                (or
                                    (and  
                                        (flowLocation ?flow locationOfRole1)
                                        (currentLocation ?role1 ?location)
                                    )
                                    (and  
                                        (flowLocation ?flow locationOfResource1)
                                        (currentLocation ?resource1 ?location)
                                    )
                                )    
                                (intent ?action ?role1 ?role1 ?resource1 ?location)    
                            )
                        )
                    )
                )
            )
        )   
    )
)


(:action instantiate-recipe1role1resource-otherLocation
    :parameters (?recipe - recipe1role1resource ?role1 - actor ?resource1 - resource ?location - location)
    :precondition (and 
        (recipeClauseOf ?flow ?recipe)
        (flowAction ?flow ?action)
        (flowProvider ?flow role1)
        (flowReceiver ?flow role1)
        (flowResource ?flow resource1)
        (or
            (and  
                (flowLocation ?flow locationOfRole1)
                (currentLocation ?role1 ?location)
            )
            (and  
                (flowLocation ?flow locationOfResource1)
                (currentLocation ?resource1 ?location)
            )
            (flowLocation ?flow otherLocation)
        )    
    )    
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (and 
                    (recipeClauseOf ?flow ?recipe)
                    (flowLocation ?flow otherLocation)
                    (flowProvider ?flow role1)
                    (flowReceiver ?flow role1)
                    (flowResource ?flow resource1)
                )
                (forall (?action - action)
                    (when 
                        (flowAction ?flow ?action)
                        (intent ?action ?role1 ?role1 ?resource1 ?location)    
                    )
                )
            )
        )   
    )
)


(:action instantiate-recipe2roles1resource
    :parameters (?recipe - recipe2roles1resource ?role1 ?role2 - actor ?resource1 - resource)
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (recipeClauseOf ?flow ?recipe)
                (when 
                    (flowResource ?flow resource1)
                    (forall (?action - action)
                        (when 
                            (flowAction ?flow ?action)
                            (forall (?location - location) 
                                (when
                                    (or
                                        (and  
                                            (flowLocation ?flow locationOfRole1)
                                            (currentLocation ?role1 ?location)
                                        )
                                        (and  
                                            (flowLocation ?flow locationOfRole2)
                                            (currentLocation ?role2 ?location)
                                        )
                                        (and  
                                            (flowLocation ?flow locationOfResource1)
                                            (currentLocation ?resource1 ?location)
                                        )
                                    )    
                                    (forall (?provider - actor)
                                        (when 
                                            (or
                                                (and
                                                    (flowProvider ?flow role1)
                                                    (= ?role1 ?provider)
                                                )
                                                (and
                                                    (flowProvider ?flow role2)
                                                    (= ?role2 ?provider)
                                                )
                                            )
                                            (forall (?receiver - actor)
                                                (when 
                                                    (or
                                                        (and
                                                            (flowReceiver ?flow role1)
                                                            (= ?role1 ?receiver)
                                                        )
                                                        (and
                                                            (flowReceiver ?flow role2)
                                                            (= ?role2 ?receiver)
                                                        )
                                                    )
                                                    (intent ?action ?provider ?receiver ?resource1 ?location)    
                                                )
                                            )
                                        )
                                    )   
                                )
                            )
                        )
                    )
                )
            )
        )   
    )
)


(:action instantiate-recipe2roles1resource-otherLocation
    :parameters (?recipe - recipe2roles1resource ?role1 ?role2 - actor ?resource1 - resource ?location - location)
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (and 
                    (recipeClauseOf ?flow ?recipe)
                    (flowLocation ?flow otherLocation)
                )
                (when 
                    (flowResource ?flow resource1)
                    (forall (?action - action)
                        (when 
                            (flowAction ?flow ?action)
                            (forall (?provider - actor)
                                (when 
                                    (or
                                        (and
                                            (flowProvider ?flow role1)
                                            (= ?role1 ?provider)
                                        )
                                        (and
                                            (flowProvider ?flow role2)
                                            (= ?role2 ?provider)
                                        )
                                    )
                                    (forall (?receiver - actor)
                                        (when 
                                            (or
                                                (and
                                                    (flowReceiver ?flow role1)
                                                    (= ?role1 ?receiver)
                                                )
                                                (and
                                                    (flowReceiver ?flow role2)
                                                    (= ?role2 ?receiver)
                                                )
                                            )
                                            (intent ?action ?provider ?receiver ?resource1 ?location)    
                                        )
                                    )
                                )
                            )   
                        )
                    )
                )
            )
        )   
    )
)


(:action instantiate-recipe2roles2resources
    :parameters (?recipe - recipe2roles2resources ?role1 ?role2 - actor ?resource1 ?resource2 - resource)
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (recipeClauseOf ?flow ?recipe)
                (forall (?action - action)
                    (when 
                        (flowAction ?flow ?action)
                        (forall (?location - location) 
                            (when
                                (or
                                    (and  
                                        (flowLocation ?flow locationOfRole1)
                                        (currentLocation ?role1 ?location)
                                    )
                                    (and  
                                        (flowLocation ?flow locationOfRole2)
                                        (currentLocation ?role2 ?location)
                                    )
                                    (and  
                                        (flowLocation ?flow locationOfResource1)
                                        (currentLocation ?resource1 ?location)
                                    )
                                    (and  
                                        (flowLocation ?flow locationOfResource2)
                                        (currentLocation ?resource2 ?location)
                                    )
                                )    
                                (forall (?provider - actor)
                                    (when 
                                        (or
                                            (and
                                                (flowProvider ?flow role1)
                                                (= ?role1 ?provider)
                                            )
                                            (and
                                                (flowProvider ?flow role2)
                                                (= ?role2 ?provider)
                                            )
                                        )
                                        (forall (?receiver - actor)
                                            (when 
                                                (or
                                                    (and
                                                        (flowReceiver ?flow role1)
                                                        (= ?role1 ?receiver)
                                                    )
                                                    (and
                                                        (flowReceiver ?flow role2)
                                                        (= ?role2 ?receiver)
                                                    )
                                                )
                                                (forall (?resource - resource)
                                                    (when
                                                        (or
                                                            (and
                                                                (flowResource ?flow resource1)
                                                                (= ?resource1 ?resource)
                                                            )
                                                            (and
                                                                (flowResource ?flow resource2)
                                                                (= ?resource2 ?resource)
                                                            )
                                                        )
                                                        (intent ?action ?provider ?receiver ?resource ?location)    
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )   
                            )
                        )
                    )
                )
            )
        )   
    )
)


(:action instantiate-recipe2roles2resources-otherLocation
    :parameters (?recipe - recipe2roles2resources ?role1 ?role2 - actor ?resource1 ?resource2 - resource ?location - location)
    :effect  
    (and
        (forall (?flow - recipeFlow) 
            (when
                (and 
                    (recipeClauseOf ?flow ?recipe)
                    (flowLocation ?flow otherLocation)
                )
                (forall (?action - action)
                    (when 
                        (flowAction ?flow ?action)
                        (forall (?provider - actor)
                            (when 
                                (or
                                    (and
                                        (flowProvider ?flow role1)
                                        (= ?role1 ?provider)
                                    )
                                    (and
                                        (flowProvider ?flow role2)
                                        (= ?role2 ?provider)
                                    )
                                )
                                (forall (?receiver - actor)
                                    (when 
                                        (or
                                            (and
                                                (flowReceiver ?flow role1)
                                                (= ?role1 ?receiver)
                                            )
                                            (and
                                                (flowReceiver ?flow role2)
                                                (= ?role2 ?receiver)
                                            )
                                        )
                                        (forall (?resource - resource)
                                            (when 
                                                (or
                                                    (and
                                                        (flowResource ?flow resource1)
                                                        (= ?resource1 ?resource)
                                                    )
                                                    (and
                                                        (flowResource ?flow resource2)
                                                        (= ?resource2 ?resource)
                                                    )
                                                )
                                                (intent ?action ?provider ?receiver ?resource ?location)    
                                            )
                                        )
                                    )
                                )
                            )
                        )   
                    )
                )
            )
        )   
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
        (currentLocation ?driver ?l)
        (currentLocation ?vehicle ?l)
        (currentLocation ?passenger ?l)
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
