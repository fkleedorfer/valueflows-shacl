

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
    recipe
    recipe1role1resource - recipe
    recipe2roles1resource - recipe
    recipe2roles2resources - recipe
    recipe3roles1resource - recipe
    recipe3roles2resources - recipe
    recipeProcess
    recipeLocation 
)

; un-comment following line if constants are needed
(:constants 
    transfer move goto transfer-all-rights transfer-custody mount dismount put-into take-out-of begin-use end-use use - action
    null - thing
    role1 role2 role3 - role
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
    (recipeFlow ?recipe - recipe ?action - action ?role1 ?role2 - role ?resource1 - recipeResource ?location - recipeLocation)
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
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
            )
        )
)

(:action instantiate-recipe1role1resource-otherLocation
    :parameters (?recipe - recipe1role1resource ?role1 - actor ?resource1 - resource ?location - location)
    :effect  
        (forall (?recipe - recipe ?action - action) 
            (and
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource1 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
            )
        )
)




(:action instantiate-recipe2roles1resource
    :parameters (?recipe - recipe2roles1resource ?role1 ?role2 - actor ?resource1 - resource)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
            )
        )
)

(:action instantiate-recipe2roles1resource-otherLocation
    :parameters (?recipe - recipe2roles1resource ?role1 ?role2 - actor ?resource1 - resource ?location - location)
    :effect  

        (forall (?recipe - recipe ?action - action) 
            (and
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource1 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource1 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource1 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource1 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
            )
        )
)

(:action instantiate-recipe2roles2resources
    :parameters (?recipe - recipe2roles2resources ?role1 ?role2 - actor ?resource1 ?resource2 - resource)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;               resource 2                                  ;;
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource2 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource2 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource2 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource2 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource2 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource2 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource2 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource2 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
            )
        )
)

(:action instantiate-recipe2roles2resources-otherLocation
    :parameters (?recipe - recipe2roles2resources ?role1 ?role2 - actor ?resource1 ?resource2 - resource ?location - location)
    :effect  

        (forall (?recipe - recipe ?action - action) 
            (and
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource1 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource1 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource1 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource1 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ;; resource 2
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource2 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource2 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource2 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource2 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
            )
        )
)


(:action instantiate-recipe3roles1resource
    :parameters (?recipe - recipe3roles1resource ?role1 ?role2 ?role3 - actor ?resource1 - resource)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                ; role1 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                ; role1 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                ; role2 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                ; role2 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                ; role3 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                ; role3 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                ; role1 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                ; role2 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ; role3 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
            )
        )
)


(:action instantiate-recipe3roles1resource-otherLocation
    :parameters (?recipe - recipe3roles1resource ?role1 ?role2 ?role3 - actor ?resource1 - resource ?location - location)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                ; role1 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource1 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                ; role1 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role3 resource1 otherLocation)
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                ; role2 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role3 resource1 otherLocation)
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                ; role2 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource1 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                ; role3 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role1 resource1 otherLocation)
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                ; role3 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role2 resource1 otherLocation)
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                ; role1 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource1 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                ; role2 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource1 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ; role3 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role3 resource1 otherLocation)
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
            )
        )
)




(:action instantiate-recipe3roles2resources
    :parameters (?recipe - recipe3roles2resource ?role1 ?role2 ?role3 - actor ?resource1 ?resource2 - resource)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                ; role1 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                ; role1 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                ; role2 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                ; role2 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                ; role3 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                ; role3 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                ; role1 role1 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource1 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                )
                ; role2 role2 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource1 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ; role3 role3 resource 1
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource1 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;                         resource 2                        ;;
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                
                ; role1 role2 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role2 resource2 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource2 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role2 resource2 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                ; role1 role3 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role3 resource2 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource2 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role3 resource2 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role3 ?resource2 ?location)
                )
                ; role2 role3 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role3 resource2 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource2 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role3 resource2 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role3 ?resource2 ?location)
                )
                ; role2 role1 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role2 role1 resource2 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource2 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role2 role1 resource2 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                ; role3 role1 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role1 resource2 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource2 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role1 resource2 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role1 ?resource2 ?location)
                )
                ; role3 role2 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location)
                        (recipeFlow ?recipe ?action role3 role2 resource2 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource2 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location) 
                        (recipeFlow ?recipe ?action role3 role2 resource2 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role2 ?resource2 ?location)
                )
                ; role1 role1 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role1 role1 resource2 locationOfRole1)
                    )
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource2 locationOfRole2)
                    )
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role1 role1 resource2 locationOfRole3)
                    )
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                ; role2 role2 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role2 role2 resource2 locationOfRole1)
                    )
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource2 locationOfRole2)
                    )
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role2 role2 resource2 locationOfRole3)
                    )
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
                ; role3 role3 resource 2
                (when
                    (and 
                        (currentLocation ?role1 ?location) 
                        (recipeFlow ?recipe ?action role3 role3 resource2 locationOfRole1)
                    )
                    (intent ?action ?role3 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role2 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource2 locationOfRole2)
                    )
                    (intent ?action ?role3 ?role3 ?resource2 ?location)
                )
                (when
                    (and 
                        (currentLocation ?role3 ?location ) 
                        (recipeFlow ?recipe ?action role3 role3 resource2 locationOfRole3)
                    )
                    (intent ?action ?role3 ?role3 ?resource2 ?location)
                )
            )
        )
)

(:action instantiate-recipe3roles2resources-otherLocation
    :parameters (?recipe - recipe3roles2resource ?role1 ?role2 ?role3 - actor ?resource1 ?reource2 - resource ?location - location)
    :effect  

        (forall (?recipe - recipe ?action - action ?location - location) 
            (and
                ; role1 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource1 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource1 ?location)
                )
                ; role1 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role3 resource1 otherLocation)
                    (intent ?action ?role1 ?role3 ?resource1 ?location)
                )
                ; role2 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role3 resource1 otherLocation)
                    (intent ?action ?role2 ?role3 ?resource1 ?location)
                )
                ; role2 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource1 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource1 ?location)
                )
                ; role3 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role1 resource1 otherLocation)
                    (intent ?action ?role3 ?role1 ?resource1 ?location)
                )
                ; role3 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role2 resource1 otherLocation)
                    (intent ?action ?role3 ?role2 ?resource1 ?location)
                )
                ; role1 role1 resource 1
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource1 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource1 ?location)
                ) 
                ; role2 role2 resource 1
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource1 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource1 ?location)
                )
                ; role3 role3 resource 1
                (when
                    (recipeFlow ?recipe ?action role3 role3 resource1 otherLocation)
                    (intent ?action ?role3 ?role3 ?resource1 ?location)
                )
                
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;                         resource 2                        ;;
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                
                ; role1 role2 resource 2
                (when
                    (recipeFlow ?recipe ?action role1 role2 resource2 otherLocation)
                    (intent ?action ?role1 ?role2 ?resource2 ?location)
                )
                ; role1 role3 resource 2
                (when
                    (recipeFlow ?recipe ?action role1 role3 resource2 otherLocation)
                    (intent ?action ?role1 ?role3 ?resource2 ?location)
                )
                ; role2 role3 resource 2
                (when
                    (recipeFlow ?recipe ?action role2 role3 resource2 otherLocation)
                    (intent ?action ?role2 ?role3 ?resource2 ?location)
                )
                ; role2 role1 resource 2
                (when
                    (recipeFlow ?recipe ?action role2 role1 resource2 otherLocation)
                    (intent ?action ?role2 ?role1 ?resource2 ?location)
                )
                ; role3 role1 resource 2
                (when
                    (recipeFlow ?recipe ?action role3 role1 resource2 otherLocation)
                    (intent ?action ?role3 ?role1 ?resource2 ?location)
                )
                ; role3 role2 resource 2
                (when
                    (recipeFlow ?recipe ?action role3 role2 resource2 otherLocation)
                    (intent ?action ?role3 ?role2 ?resource2 ?location)
                )
                ; role1 role1 resource 2
                (when
                    (recipeFlow ?recipe ?action role1 role1 resource2 otherLocation)
                    (intent ?action ?role1 ?role1 ?resource2 ?location)
                )
                ; role2 role2 resource 2
                (when
                    (recipeFlow ?recipe ?action role2 role2 resource2 otherLocation)
                    (intent ?action ?role2 ?role2 ?resource2 ?location)
                )
                ; role3 role3 resource 2
                (when
                    (recipeFlow ?recipe ?action role3 role3 resource2 otherLocation)
                    (intent ?action ?role3 ?role3 ?resource2 ?location)
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
