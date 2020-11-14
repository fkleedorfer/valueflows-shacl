

(define (domain valueflows)


(:requirements :adl :action-costs :typing :derived-predicates)

(:types 
    thing
    actor - thing
    resource - thing 
    intangibleResource - resource
    tangibleResource - resource
    money - intangibleResource
    vehicle - tangibleResource
    truck - vehicle
    car - vehicle
    location
    action
    resourceClassType
    vehicleClassType - resourceClassType
    serviceClassType - resourceClassType
    recipeProcess
    recipeFlow
)

(:constants 
    produce consume transfer  transfer-all-rights transfer-custody move mount dismount put-into take-out-of begin-use end-use use deliver-service lend drive travel - action
    TransportServiceClass - serviceClassType
    TaxiServiceClass - serviceClassType
    TruckClass - vehicleClassType
    CarClass - vehicleClassType
    MoneyClass - resourceClassType
)

(:functions (total-cost - numeric))

(:predicates 
    (currentLocation ?t - thing ?l - location) ; t is at location l
    (resourceClassification ?r - resource ?c - resourceClassType )
    (custodian ?r - resource ?a - actor ) ; a is currently in custody of r
    (primaryAccountable ?r - resource ?a - actor) ; a is the owner of r
    (potentialResource ?r - resource)
    (reservedForProduce ?r - resource)
    (requiresIngredient ?product ?ingredient - resourceClassType)
    (recipeInputOf ?process - recipeProcess ?flow - recipeFlow)
    (recipeOutputOf ?process - recipeProcess ?flow - recipeFlow)
    (recipeFlowDef ?flow - recipeFlow ?action - action ?resourceClassType - resourceClassType)
    (problemSolved) ; set if problem is solved
    (debug) ;trigger for removing intents and commitments
    (debugRemoveUnusedIntents) ; trigger for removing intents
    (debugRemoveUnusedCommitments); trigger for removing commitments
    (providesService ?actor - actor ?serviceClass - serviceClassType)

    (intent-aprrltc ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location ?c - resourceClassType)
    (intent-aprrlt- ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    (intent-aprrl-c ?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    (intent-aprrl-- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (intent-apr-lt- ?action - action ?provider ?receiver - actor ?l ?t - location)    
    (intent-apr-l-c ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)    
    (intent-aprr--- ?action - action ?provider ?receiver - actor ?r - resource)
    (intent-apr-l-- ?action - action ?provider ?receiver - actor ?l - location)    
    (intent-apr---c ?action - action ?provider ?receiver - actor ?c - resourceClassType)
    (intent-ap-rl-- ?action - action ?provider - actor ?r - resource ?l - location)
    (intent-ap-r--c ?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    (intent-ap--l-c ?action - action ?provider - actor ?l - location ?c - resourceClassType)
    (intent-a-rrl-- ?action - action ?receiver - actor ?r - resource ?l - location)
    (intent-a-r-l-c ?action - action ?receiver - actor ?l - location ?c - resourceClassType)
    (intent-apr---- ?action - action ?provider ?receiver - actor )
    (intent-ap-r--- ?action - action ?provider - actor ?r - resource)
    (intent-ap----c ?action - action ?provider - actor ?c - resourceClassType)
    (intent-a-rr--- ?action - action ?receiver - actor ?r - resource)
    (intent-a-r---c ?action - action ?receiver - actor ?c - resourceClassType)
    (intent-ap----- ?action - action ?provider - actor)



    (persistent-intent-aprrltc ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location ?c - resourceClassType)
    (persistent-intent-aprrlt- ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    (persistent-intent-aprrl-c ?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    (persistent-intent-aprrl-- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (persistent-intent-apr-lt- ?action - action ?provider ?receiver - actor ?l ?t - location)        
    (persistent-intent-apr-l-c ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType)    
    (persistent-intent-aprr--- ?action - action ?provider ?receiver - actor ?r - resource )
    (persistent-intent-apr---c ?action - action ?provider ?receiver - actor ?c - resourceClassType)
    (persistent-intent-apr-l-- ?action - action ?provider ?receiver - actor ?l - location )    
    (persistent-intent-ap-rl-- ?action - action ?provider - actor ?r - resource ?l - location )
    (persistent-intent-ap-r--c ?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    (persistent-intent-ap--l-c ?action - action ?provider - actor ?l - location ?c - resourceClassType)
    (persistent-intent-a-rrl-- ?action - action ?receiver - actor ?r - resource ?l - location )
    (persistent-intent-a-r-l-c ?action - action ?receiver - actor ?l - location ?c - resourceClassType)
    (persistent-intent-apr---- ?action - action ?provider ?receiver - actor )
    (persistent-intent-ap-r--- ?action - action ?provider - actor ?r - resource )
    (persistent-intent-ap----c ?action - action ?provider - actor ?c - resourceClassType)
    (persistent-intent-ap----- ?action - action ?provider - actor )
    (persistent-intent-a-rr--- ?action - action ?receiver - actor ?r - resource)
    (persistent-intent-a-r---c ?action - action ?receiver - actor ?c - resourceClassType)

    (commitment-aprrltc ?action - action ?provider ?receiver - actor ?s - resource ?l ?t - location ?c - resourceClassType)
    (commitment-aprrlt- ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    (commitment-aprrl-c ?action - action ?provider ?receiver - actor ?s - resource ?l - location ?c - resourceClassType)
    (commitment-aprrl-- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (commitment-aprr--- ?action - action ?provider ?receiver - actor ?r - intangibleResource)
    (fulfillment-aprrltc ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location ?c - resourceClassType)
    (fulfillment-aprrlt- ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)    
    (fulfillment-aprrl-c ?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    (fulfillment-aprrl-- ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    (fulfillment-aprr--- ?action - action ?provider ?receiver - actor ?r - resource)
    (using ?a - actor ?r - resource) ; a is using r
    (isCarryable ?r - resource) ; an actor can move the resource
    (isVehicle ?r - resource) ; r is a vehicle
    (isPassive ?a - actor) ; actor cannot be in the provider/receiver role
    (mayContainResources ?r - resource) ; a truck, for example
    (mayContainActors ?a - actor) ; a means of person transport
    (containedIn ?rinside - thing ?rcontainer - resource) ; rinside is inside rcontainer
)

(:action commit-aprrlt- 
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location ?toLocation - location)
    :precondition (or
        (intent-aprrlt- ?action ?provider ?receiver ?resource ?location ?toLocation)
        ; (and 
        ;     (intent-ap-rlt- ?action ?provider ?resource ?location ?toLocation)
        ;     (intent-a-rrlt- ?action ?receiver ?resource ?location ?toLocation)
        ; )
    )
    :effect (and
        (commitment-aprrlt- ?action ?provider ?receiver ?resource ?location ?toLocation)
        (not (intent-aprrlt- ?action ?provider ?receiver ?resource ?location ?toLocation))
        ; (not (intent-ap-rlt- ?action ?provider ?resource ?location ?toLocation))
        ; (not (intent-a-rrlt- ?action ?receiver ?resource ?location ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action commit-aprrl-- 
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition (or
        (intent-aprrl-- ?action ?provider ?receiver ?resource ?location)
        (and 
            (intent-ap-rl-- ?action ?provider ?resource ?location)
            (intent-a-rrl-- ?action ?receiver ?resource ?location)
        )
        (and
            (= ?action transfer-all-rights)
            (or
                (and
                    (intent-ap-rl-- ?action ?provider ?resource ?location)
                    (intent-a-rr--- ?action ?receiver ?resource)
                )
                (and
                    (intent-ap-r--- ?action ?provider ?resource)
                    (intent-a-rrl-- ?action ?receiver ?resource ?location)
                )
            )
        )
    )
    :effect (and
        (commitment-aprrl-- ?action ?provider ?receiver ?resource ?location)
        (not (intent-aprrl-- ?action ?provider ?receiver ?resource ?location))
        (not (intent-ap-rl-- ?action ?provider ?resource ?location))
        (not (intent-a-rrl-- ?action ?receiver ?resource ?location))
        (not (intent-ap-rl-- ?action ?provider ?resource ?location))
        (not (intent-a-rr--- ?action ?receiver ?resource))
        (not (intent-ap-r--- ?action ?provider ?resource))
        (not (intent-a-rrl-- ?action ?receiver ?resource ?location))
        (increase (total-cost) 1)
    )
)

(:action commit-aprrl-c
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location ?c - resourceClassType)
    :precondition 
        (intent-aprrl-c ?action ?provider ?receiver ?resource ?location ?c)
    :effect (and
        (commitment-aprrl-c ?action ?provider ?receiver ?resource ?location ?c)
        (not (intent-aprrl-c ?action ?provider ?receiver ?resource ?location ?c))
        (increase (total-cost) 1)
    )
)

(:action commit-aprr---
    :parameters (?action - action ?provider ?receiver - actor ?resource - intangibleResource)
    :precondition (or
        (intent-aprr--- ?action ?provider ?receiver ?resource)
        (and 
            (intent-ap-r--- ?action ?provider ?resource)
            (intent-a-rr--- ?action ?receiver ?resource)
        )
    )
    :effect (and
        (commitment-aprr--- ?action ?provider ?receiver ?resource)
        (not (intent-aprr--- ?action ?provider ?receiver ?resource))
        (increase (total-cost) 1)
    )
)

; create an intent from an persistent-intent

(:action instantiate-intent-aprrltc
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location ?c - resourceClassType)
    :precondition
        (persistent-intent-aprrltc ?action ?provider ?receiver ?r ?l ?t ?c)
    :effect         
        (and
            (intent-aprrltc ?action ?provider ?receiver ?r ?l ?t ?c)
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-aprrl-c
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    :precondition
        (persistent-intent-aprrl-c ?action ?provider ?receiver ?r ?l ?c)
    :effect         
        (and
            (intent-aprrl-c ?action ?provider ?receiver ?r ?l ?c)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-apr---c
    :parameters ( ?action - action ?provider ?receiver - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-apr---c ?action ?provider ?receiver ?c )
    :effect         
        (and
            (intent-apr---c ?action ?provider ?receiver ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap-r--c
    :parameters (?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    :precondition
        (persistent-intent-ap-r--c ?action ?provider ?r ?c)
    :effect         
        (and
            (intent-ap-r--c ?action ?provider ?r ?c)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-apr-l-c
    :parameters ( ?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType )    
    :precondition
        (persistent-intent-apr-l-c ?action ?provider ?receiver ?l ?c )
    :effect         
        (and
            (intent-apr-l-c ?action ?provider ?receiver ?l ?c )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-ap--l-c
    :parameters ( ?action - action ?provider - actor ?l - location ?c - resourceClassType )
    :precondition
        (persistent-intent-ap--l-c ?action ?provider ?l ?c )
        :effect         
        (and
            (intent-ap--l-c ?action ?provider ?l ?c )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-a-r-l-c
    :parameters ( ?action - action ?receiver - actor ?l - location ?c - resourceClassType )
    :precondition
        (persistent-intent-a-r-l-c ?action ?receiver ?l ?c )
    :effect         
        (and
            (intent-a-r-l-c ?action ?receiver ?l ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-a-r---c
    :parameters ( ?action - action ?receiver - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-a-r---c ?action ?receiver ?c )
    :effect         
        (and
            (intent-a-r---c ?action ?receiver ?c )
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-apr---c
    :parameters ( ?action - action ?provider ?receiver - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-apr---c ?action ?provider ?receiver ?c )
        :effect         
        (and
            (intent-apr---c ?action ?provider ?receiver ?c )
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap----c
    :parameters ( ?action - action ?provider - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-ap----c ?action ?provider ?c )
        :effect         
        (and
            (intent-ap----c ?action ?provider ?c )
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-ap----c
    :parameters ( ?action - action ?provider - actor ?c - resourceClassType )
    :precondition
        (persistent-intent-ap----c ?action ?provider ?c )
        :effect         
        (and
            (intent-ap----c ?action ?provider ?c )
            (increase (total-cost) 1)
        )
)


; no class
(:action instantiate-intent-aprrlt-
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    :precondition
        (persistent-intent-aprrlt- ?action ?provider ?receiver ?r ?l ?t)
    :effect         
        (and
            (intent-aprrlt- ?action ?provider ?receiver ?r ?l ?t)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-aprrl--
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-aprrl-- ?action ?provider ?receiver ?r ?l)
    :effect         
        (and
            (intent-aprrl-- ?action ?provider ?receiver ?r ?l)
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-aprr--
    :parameters ( ?action - action ?provider ?receiver - actor ?r - resource)
    :precondition
        (persistent-intent-aprr--- ?action ?provider ?receiver ?r )
    :effect         
        (and
            (intent-aprr--- ?action ?provider ?receiver ?r )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-apr-l--
    :parameters ( ?action - action ?provider ?receiver - actor ?l - location)    
    :precondition
        (persistent-intent-apr-l-- ?action ?provider ?receiver ?l )
    :effect         
        (and
            (intent-apr-l-- ?action ?provider ?receiver ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-ap-rl---
    :parameters ( ?action - action ?provider - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-ap-rl-- ?action ?provider ?r ?l )
        :effect         
        (and
            (intent-ap-rl-- ?action ?provider ?r ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-apr-lt--
    :parameters ( ?action - action ?provider ?receiver - actor ?l ?t - location)    
    :precondition
        (persistent-intent-apr-lt- ?action ?provider ?receiver ?l ?t)
    :effect         
        (and
            (intent-apr-lt- ?action ?provider ?receiver ?l ?t )
            (increase (total-cost) 1)
        )
    )

(:action instantiate-intent-a-rrl--
    :parameters ( ?action - action ?receiver - actor ?r - resource ?l - location)
    :precondition
        (persistent-intent-a-rrl-- ?action ?receiver ?r ?l )
    :effect         
        (and
            (intent-a-rrl-- ?action ?receiver ?r ?l )
            (increase (total-cost) 1)
        )
    )
(:action instantiate-intent-a-rr---
    :parameters ( ?action - action ?receiver - actor ?r - resource)
    :precondition
        (persistent-intent-a-rr--- ?action ?receiver ?r)
    :effect         
        (and
            (intent-a-rr--- ?action ?receiver ?r)
            (increase (total-cost) 1)
        )
    )

(:action instantiate-intent-apr----
    :parameters ( ?action - action ?provider ?receiver - actor)
    :precondition
        (persistent-intent-apr---- ?action ?provider ?receiver)
        :effect         
        (and
            (intent-apr---- ?action ?provider ?receiver)
            (increase (total-cost) 1)
        )
)
(:action instantiate-intent-ap-r---
    :parameters ( ?action - action ?provider - actor ?r - resource)
    :precondition
        (persistent-intent-ap-r--- ?action ?provider ?r )
        :effect         
        (and
            (intent-ap-r--- ?action ?provider ?r )
            (increase (total-cost) 1)
        )
)

(:action instantiate-intent-ap-----
    :parameters ( ?action - action ?provider - actor)
    :precondition
        (persistent-intent-ap----- ?action ?provider )
        :effect         
        (and
            (intent-ap----- ?action ?provider )
            (increase (total-cost) 1)
        )
)


;------------------------------------------------------------------------------
;
;                    Match with resources
;
;------------------------------------------------------------------------------


; match-resource: turn an intent with a resourceClassifiedAs into an intent with a resource of that class
(:action match-resource-a-r-l-c
    :parameters (?action - action ?receiver - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-a-r-l-c ?action ?receiver ?l ?c)
    )
    :effect (and
        (intent-a-rrl-- ?action ?receiver ?resource ?l)
        (not (intent-a-r-l-c ?action ?receiver ?l ?c))
        (increase (total-cost) 1)
    )
)

(:action match-resource-a-r--c
    :parameters (?action - action ?receiver - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-a-r---c ?action ?receiver ?c)
    )
    :effect (and
        (intent-a-rr--- ?action ?receiver ?resource)
        (not (intent-a-r---c ?action ?receiver ?c))
        (increase (total-cost) 1)
    )
)

(:action match-resource-ap--l-c
    :parameters (?action - action ?provider - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-ap--l-c ?action ?provider ?l ?c )
    )
    :effect (and
        (intent-ap-rl-- ?action ?provider ?resource ?l)
        (not (intent-ap--l-c ?action ?provider ?l ?c ))
        (increase (total-cost) 1)
    )
)

(:action match-resource-apr-l-c
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-apr-l-c ?action ?provider ?receiver ?l ?c)    
    )
    :effect (and
        (intent-aprrl-- ?action ?provider ?receiver ?resource ?l)    
        (not (intent-apr-l-c ?action ?provider ?receiver ?l ?c))
        (increase (total-cost) 1)
    )
)

(:action match-resource-apr---c
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-apr---c ?action ?provider ?receiver ?c)
    )
    :effect (and
        (intent-aprr--- ?action ?provider ?receiver ?resource)    
        (not (intent-apr---c ?action ?provider ?receiver ?c))
        (increase (total-cost) 1)
    )
)

(:action match-resource-ap----c
    :parameters (?action - action ?provider - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-ap----c ?action ?provider ?c)
    )
    :effect (and
        (intent-ap-r--- ?action ?provider ?resource)
        (not (intent-ap----c ?action ?provider ?c))
        (increase (total-cost) 1)
    )
)

(:action match-resource-a-r---c
    :parameters (?action - action ?receiver - actor ?resource - resource ?c - resourceClassType)
    :precondition (and 
        (resourceClassification ?resource ?c)
        (intent-a-r---c ?action ?receiver ?c)
    )
    :effect (and
        (intent-a-rr--- ?action ?receiver ?resource)
        (not (intent-a-r---c ?action ?receiver ?c))
        (increase (total-cost) 1)
    )
)

;------------------------------------------------------------------------------
;
;                    MATCH LOCATIONS
;
;------------------------------------------------------------------------------
; turn an intent without a location into an intent with a location based on the other bound variables

(:action match-location-a-rr---
    :parameters (?action - action ?receiver - actor ?resource - resource ?location - location)
    :precondition (and 
        (currentLocation ?receiver ?location)
        (intent-a-rr--- ?action ?receiver ?resource)
    )
    :effect (and
        (intent-a-rrl-- ?action ?receiver ?resource ?location)
        (not (intent-a-rr--- ?action ?receiver ?resource))
        (increase (total-cost) 1)
    )
)


(:action match-location-ap-r---
    :parameters (?action - action ?provider - actor ?resource - resource ?location - location)
    :precondition (and 
        (currentLocation ?provider ?location)
        (intent-ap-r--- ?action ?provider ?resource)
    )
    :effect (and
        (intent-ap-rl-- ?action ?provider ?resource ?location)
        (not (intent-ap-r--- ?action ?provider ?resource))
        (increase (total-cost) 1)
    )
)

(:action match-location-prov-aprr---
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition (and 
        (currentLocation ?provider ?location)
        (intent-aprr--- ?action ?provider ?receiver ?resource)
    )
    :effect (and
        (intent-aprrl-- ?action ?provider ?receiver ?resource ?location)
        (not (intent-aprr--- ?action ?provider ?receiver ?resource))
        (increase (total-cost) 1)
    )
)

(:action match-location-recv-aprr---
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition (and 
        (currentLocation ?receiver ?location)
        (intent-aprr--- ?action ?provider ?receiver ?resource)
    )
    :effect (and
        (intent-aprrl-- ?action ?provider ?receiver ?resource ?location)
        (not (intent-aprr--- ?action ?provider ?receiver ?resource))
        (increase (total-cost) 1)
    )
)

(:action match-location-res-aprr---
    :parameters (?action - action ?provider ?receiver - actor ?resource - resource ?location - location)
    :precondition (and 
        (currentLocation ?resource ?location)
        (intent-aprr--- ?action ?provider ?receiver ?resource)
    )
    :effect (and
        (intent-aprrl-- ?action ?provider ?receiver ?resource ?location)
        (not (intent-aprr--- ?action ?provider ?receiver ?resource))
        (increase (total-cost) 1)
    )
)

;------------------------------------------------------------------------------
;
;                    RECIPES
;
;------------------------------------------------------------------------------

(:action pattern-travel-to-intent-location
    :parameters (?actor - actor ?fromLocation ?toLocation - location)
    :precondition (and 
        (exists (?action - action ?otherActor - actor ?resource - resource ) 
            (or
                (intent-aprrl-- ?action ?actor ?otherActor ?resource ?toLocation)
                (intent-aprrl-- ?action ?otherActor ?actor ?resource ?toLocation)
            )
        )
        (or
            (exists (?otherLocation - location) 
                (intent-apr-lt- travel ?actor ?actor ?otherLocation ?fromLocation)
            )
            (currentLocation ?actor ?fromLocation)
        )
    )
    :effect (and 
        (intent-apr-lt- travel ?actor ?actor ?fromLocation ?toLocation)
        (increase (total-cost) 1)
    )
)

(:action pattern-drive
    :parameters (?driver - actor ?car - vehicle ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (isVehicle ?car)
        ; (custodian ?car ?driver) ; this is detrimental! don't use it!
        ;(currentLocation ?car ?fromLocation)
        ;(currentLocation ?driver ?fromLocation)
        (intent-apr-lt- travel ?driver ?driver ?fromLocation ?toLocation)
    )
    :effect (and 
        (intent-aprrlt- move ?driver ?driver ?car ?fromLocation ?toLocation)
        (not (intent-apr-lt- travel ?driver ?driver ?fromLocation ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action pattern-taxi
    :parameters (?driver ?passenger - actor  ?car - resource ?fromLocation ?toLocation - location)
    :precondition (and 
        (not (= ?fromLocation ?toLocation))
        (not (= ?driver ?passenger))
        (isVehicle ?car)
        (mayContainActors ?car)
        (or 
            (intent-ap----c deliver-service ?driver TaxiServiceClass)   
            (intent-ap-r--c deliver-service ?driver ?car TaxiServiceClass) 
        )
        (intent-apr-lt- travel ?passenger ?passenger ?fromLocation ?toLocation)
    )
    :effect (and 
        (intent-aprrl-- mount ?driver ?passenger ?car ?fromLocation)
        (intent-aprrlt- move ?driver ?driver ?car ?fromLocation ?toLocation)
        (intent-aprrl-- dismount ?driver ?passenger ?car ?toLocation)
        (not (intent-ap-r--c deliver-service ?driver ?car TaxiServiceClass) )
        (not (intent-ap----c deliver-service ?driver TaxiServiceClass) )
        (not (intent-apr-lt- travel ?passenger ?passenger ?fromLocation ?toLocation))
        (increase (total-cost) 1)
    )
)

(:action pattern-transport
    :parameters (?transporter ?consignor ?consignee ?contractee - actor  ?truck ?consignment - resource ?fromLocation ?toLocation - location)
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
            (intent-ap-r--c deliver-service ?transporter ?truck TransportServiceClass)
            (intent-ap----c deliver-service ?transporter TransportServiceClass)
            (intent-apr---c deliver-service ?transporter ?contractee TransportServiceClass)
        )
        (and 
            (intent-aprrl-- transfer-custody ?consignor ?transporter ?consignment ?fromLocation )
            (intent-aprrl-- transfer-custody ?transporter ?consignee ?consignment ?toLocation )
        )
    )
    :effect (and 
        (intent-aprrlt- move ?transporter ?transporter ?truck ?fromLocation ?toLocation)
        (not (intent-ap-r--c deliver-service ?transporter ?truck TransportServiceClass))
        (not (intent-ap----c deliver-service ?transporter TransportServiceClass))
        (increase (total-cost) 1)
    )
)

(:action pattern-borrow
    :parameters (?lender ?borrower - actor ?resource - resource ?location - location)
    :precondition (and 
        (primaryAccountable ?resource ?lender)
        (not (= ?lender ?borrower))
        (or
            (intent-ap-r--- lend ?lender ?resource)
            (intent-ap-rl-- lend ?lender ?resource ?location)
            (intent-aprrl-- lend ?lender ?borrower ?resource ?location)
        )
        (exists (?action - action ?actor - actor ?l ?t - location) 
            (and
                (not (= ?action consume))
                (or
                    (intent-aprrlt- ?action ?borrower ?actor ?resource ?l ?t)
                    (intent-aprrl-- ?action ?borrower ?actor ?resource ?l)
                    (intent-aprr--- ?action ?borrower ?actor ?resource)
                )
            )
        )
    )
    :effect (and
        (intent-aprrl-- transfer-custody ?lender ?borrower ?resource ?location)
        (intent-aprrl-- transfer-custody ?borrower ?lender ?resource ?location)
        (not(intent-ap-r--- lend ?lender ?resource))
        (not(intent-ap-rl-- lend ?lender ?resource ?location))
        (not(intent-aprrl-- lend ?lender ?borrower ?resource ?location))
        (increase (total-cost) 1)
    )
)

(:action pattern-intend-to-use 
    :parameters (?a - actor ?r - resource ?l - location)
    :precondition (and
        
        (exists (?action - action ?actor - actor ?t - location) 
            (and
                (not (= ?action consume))
                (or
                    (intent-aprrlt- ?action ?a ?actor ?r ?l ?t)
                    (intent-aprrl-- ?action ?a ?actor ?r ?l)
                    (intent-aprr--- ?action ?a ?actor ?r)
                )
            )
        )
    )
    :effect ( and
        (intent-aprrl-- use ?a ?a ?r ?l)
        (increase (total-cost) 1)
    )
)


(:action pattern-request-resource-for-use
    :parameters (?a - actor ?l - location ?c - resourceClassType)
    :precondition (and
        (or 
            (and 
                (intent-apr---c use ?a ?a ?c)
                (currentLocation ?a ?l)
            )
            (intent-apr-l-c use ?a ?a ?l ?c)
        )
        (not 
            (exists (?r - resource) 
                (and
                    (custodian ?r ?a ) ;TODO: even if I have such a resource, I may not have enough of it.
                    (resourceClassification ?r ?c) 
                )
            )
        )
    )
    :effect (and
        (intent-a-r-l-c transfer-custody ?a ?l ?c)
        (increase (total-cost) 1)
    )
)


(:action pattern-request-resource-by-class
    :parameters (?a - actor ?l - location ?c - resourceClassType)
    :precondition (and
        (or 
            (and 
                (intent-apr---c consume ?a ?a ?c)
                (currentLocation ?a ?l)
            )
            (intent-apr-l-c consume ?a ?a ?l ?c)
        )
    )
    :effect (and
            (intent-a-r-l-c transfer ?a ?l ?c)
            (increase (total-cost) 1)
    )
)

(:action pattern-request-resource
    :parameters (?a - actor ?r - resource)
    :precondition (or
        (intent-aprr--- consume ?a ?a ?r)
        (exists (?l - location)
            (intent-aprrl-- consume ?a ?a ?r ?l)
        )
    )
    :effect (and
            (intent-a-rr--- transfer ?a ?r)
            (increase (total-cost) 1)
    )
)

(:action pattern-sell-resource
    :parameters(?seller ?buyer - actor ?resource - resource ?price - money)
    :precondition (and 
        (primaryAccountable ?price ?buyer)
        (custodian ?price ?buyer)
        (primaryAccountable ?resource ?seller)
        (intent-a-rr--- transfer ?seller ?price)
        (intent-a-rr--- transfer ?buyer ?resource)
    )
    :effect (and
        (not (intent-a-rr--- transfer ?seller ?price))
        (intent-aprr--- transfer ?buyer ?seller ?price)
        (intent-aprr--- transfer ?seller ?buyer ?resource)
        (increase (total-cost) 1)
    )
)

(:action pattern-sell-service
    :parameters(?seller ?buyer - actor ?price - money ?serviceClass - serviceClassType)
    :precondition (and 
        (primaryAccountable ?price ?buyer)
        (custodian ?price ?buyer)
        (intent-a-rr--- transfer ?seller ?price)
        (providesService ?seller ?serviceClass)
    )
    :effect (and
        (not (intent-a-rr--- transfer ?seller ?price)) 
        (intent-aprr--- transfer ?buyer ?seller ?price)
        (intent-apr---c deliver-service ?seller ?buyer ?serviceClass)
        (increase (total-cost) 1)
    )
)


; simple version: one process that combines all ingredients/constituents
(:action pattern-process-inputs 
    :parameters (?process - recipeProcess ?a - actor ?r - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (potentialResource ?r)
        (not (reservedForProduce ?r))
        (exists (?f - recipeFlow)
            (and
                ;don't enable processes unless they produce something that's needed
                (recipeOutputOf ?process ?f)
                (recipeFlowDef ?f produce ?c)         
            )
        )
        (or
            ; a produces for themselves
            (intent-apr-l-c consume ?a ?a ?l ?c)
            (intent-apr---c consume ?a ?a ?c)
            (intent-apr-l-c use ?a ?a ?l ?c)
            (intent-apr---c use ?a ?a ?c)
            ; (exists (?o - actor) ;enables too many instantiations, needs to be restricted to agents who want to produce for others
            ;     (or
            ;         (intent-apr-l-c consume ?o ?o ?l ?c)
            ;         (intent-apr---c consume ?o ?o ?c)
            ;         (intent-apr-l-c use ?o ?o ?l ?c)
            ;         (intent-apr---c use ?o ?o ?c)
            ;     )
            ; )
        )
    )
    :effect (and 
        (forall (?f - recipeFlow ?action - action ?input - resourceClassType) 
            (when
                (and
                    (recipeInputOf ?process ?f)
                    (recipeFlowDef ?f ?action ?input) 
                )
                (intent-apr-l-c ?action ?a ?a ?l ?input)
            )
        )
        (increase (total-cost) 1)
    )
)

(:action pattern-process-outputs
    :parameters (?process - recipeProcess ?a - actor ?r - resource ?l - location)
    :precondition (and 
        (potentialResource ?r)
        (not (reservedForProduce ?r))
        (forall (?f - recipeFlow ?action - action ?input - resourceClassType) 
            (or
                (not
                    (and
                        (recipeInputOf ?process ?f)
                        (recipeFlowDef ?f ?action ?input) 
                    )
                )
                (and 
                    (recipeInputOf ?process ?f)
                    (recipeFlowDef ?f ?action ?input) 
                    (exists (?res - resource)
                        (and 
                            (resourceClassification ?res ?input)
                            (fulfillment-aprrl-- ?action ?a ?a ?res ?l)
                        )
                    )
                )
            )
        )
    )
    :effect (and 
        (forall (?f - recipeFlow ?action - action ?output - resourceClassType) 
            (when
                (and
                    (recipeOutputOf ?process ?f)
                    (recipeFlowDef ?f ?action ?output) 
                )
                (and
                    (intent-aprrl-c ?action ?a ?a ?r ?l ?output)
                    (when 
                        (= ?action produce)
                        (reservedForProduce ?r)
                    )
                )
            )
        )
        (increase (total-cost) 1)
    )
)


(:action pattern-split-transfer-a-r-l-c
    :parameters (?receiver - actor ?location - location ?class - resourceClassType)
    :precondition (intent-a-r-l-c transfer ?receiver ?location ?class)
    :effect (and
        (not (intent-a-r-l-c transfer ?receiver ?location ?class))
        (intent-a-r-l-c transfer-custody ?receiver ?location ?class)
        (intent-a-r-l-c transfer-all-rights ?receiver ?location ?class)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-aprr---
    :parameters (?provider ?receiver - actor ?resource - resource)
    :precondition (intent-aprr--- transfer ?provider ?receiver ?resource )
    :effect (and
        (not (intent-aprr--- transfer ?provider ?receiver ?resource ))
        (intent-aprr--- transfer-custody ?provider ?receiver ?resource )
        (intent-aprr--- transfer-all-rights ?provider ?receiver ?resource)
        (increase (total-cost) 1)
    )
)


(:action pattern-split-transfer--rrl--
    :parameters (?receiver - actor ?resource - resource ?location - location)
    :precondition  
        (intent-a-rrl-- transfer ?receiver ?resource ?location)
    :effect (and
        (not (intent-a-rrl-- transfer ?receiver ?resource ?location))
        (intent-a-rrl-- transfer-custody ?receiver ?resource ?location)
        (intent-a-rrl-- transfer-all-rights ?receiver ?resource ?location)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-p-rl--
    :parameters (?provider - actor ?resource - resource ?location - location)
    :precondition  
        (intent-ap-rl-- transfer ?provider ?resource ?location)
    :effect (and
        (not (intent-ap-rl-- transfer ?provider ?resource ?location))
        (intent-ap-rl-- transfer-custody ?provider ?resource ?location)
        (intent-ap-rl-- transfer-all-rights ?provider ?resource ?location)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-TAR-loc-unrestricted-a-r-l-c
    :parameters (?receiver - actor ?location - location ?class - resourceClassType)
    :precondition (intent-a-r-l-c transfer ?receiver ?location ?class)
    :effect (and
        (not (intent-a-r-l-c transfer ?receiver ?location ?class))
        (intent-a-r-l-c transfer-custody ?receiver ?location ?class)
        (intent-a-r---c transfer-all-rights ?receiver ?class)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-TAR-loc-unrestricted--rrl--
    :parameters (?receiver - actor ?resource - resource ?location - location)
    :precondition  
        (intent-a-rrl-- transfer ?receiver ?resource ?location)
    :effect (and
        (not (intent-a-rrl-- transfer ?receiver ?resource ?location))
        (intent-a-rrl-- transfer-custody ?receiver ?resource ?location)
        (intent-a-rr--- transfer-all-rights ?receiver ?resource)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-TAR-loc-unrestricted-p-rl--
    :parameters (?provider - actor ?resource - resource ?location - location)
    :precondition  
        (intent-ap-rl-- transfer ?provider ?resource ?location)
    :effect (and
        (not (intent-ap-rl-- transfer ?provider ?resource ?location))
        (intent-ap-rl-- transfer-custody ?provider ?resource ?location)
        (intent-ap-r--- transfer-all-rights ?provider ?resource)
        (increase (total-cost) 1)
    )
)






(:action pattern-split-transfer-a-r---c
    :parameters (?receiver - actor ?class - resourceClassType)
    :precondition (intent-a-r---c transfer ?receiver ?class)
    :effect (and
        (not (intent-a-r---c transfer ?receiver ?class))
        (intent-a-r---c transfer-custody ?receiver ?class)
        (intent-a-r---c transfer-all-rights ?receiver ?class)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-aprr---
    :parameters (?provider ?receiver - actor ?resource - resource)
    :precondition (intent-aprr--- transfer ?provider ?receiver ?resource )
    :effect (and
        (not (intent-aprr--- transfer ?provider ?receiver ?resource ))
        (intent-aprr--- transfer-custody ?provider ?receiver ?resource )
        (intent-aprr--- transfer-all-rights ?provider ?receiver ?resource)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer--rr---
    :parameters (?receiver - actor ?resource - resource)
    :precondition  
        (intent-a-rr--- transfer ?receiver ?resource)
    :effect (and
        (not (intent-a-rr--- transfer ?receiver ?resource))
        (intent-a-rr--- transfer-custody ?receiver ?resource)
        (intent-a-rr--- transfer-all-rights ?receiver ?resource)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-p-r---
    :parameters (?provider - actor ?resource - resource)
    :precondition  
        (intent-ap-r--- transfer ?provider ?resource)
    :effect (and
        (not (intent-ap-r--- transfer ?provider ?resource))
        (intent-ap-r--- transfer-custody ?provider ?resource)
        (intent-ap-r--- transfer-all-rights ?provider ?resource)
        (increase (total-cost) 1)
    )
)

(:action pattern-split-transfer-custody-aprr---
    :parameters (?provider ?intermediate ?receiver - actor ?resource - resource)
    :precondition (and
        (intent-aprr--- transfer-custody ?provider ?receiver ?resource )
        )
    :effect (and
        (not (intent-aprr--- transfer-custody ?provider ?receiver ?resource ))
        (intent-aprr--- transfer-custody ?provider ?intermediate ?resource )
        (intent-aprr--- transfer-custody ?intermediate ?receiver ?resource)
        (increase (total-cost) 1)
    )
)




;------------------------------------------------------------------------------
;
;                    Events
;
;------------------------------------------------------------------------------

(:action event-produce 
    :parameters (?p ?r - actor ?s - resource ?l - location ?c - resourceClassType)
    :precondition (and 
        (commitment-aprrl-c produce ?p ?r ?s ?l ?c)
        (potentialResource ?s)
        (currentLocation ?p ?l)
    )
    :effect (and 
        (not (potentialResource ?s))
        (resourceClassification ?s ?c)
        (currentLocation ?s ?l)
        (custodian ?s ?p )
        (primaryAccountable ?s ?r)   
        (not (commitment-aprrl-c produce ?p ?r ?s ?l ?c))
        (fulfillment-aprrl-c produce ?p ?r ?s ?l ?c)
        (increase (total-cost) 1)
    )
)

(:action event-consume
    :parameters (?p ?r - actor ?s - resource ?l - location)
    :precondition (and 
        (commitment-aprrl-- consume ?p ?r ?s ?l)
        (currentLocation ?p ?l)
        (currentLocation ?s ?l)
        (custodian ?s ?p )
        (or 
            (primaryAccountable ?s ?p)
            (primaryAccountable ?s ?r)
        )
    )
    :effect (and 
        (not(custodian ?s ?p ))
        (not (primaryAccountable ?s ?p))
        (not (primaryAccountable ?s ?r))
        (not (currentLocation ?s ?l))
        (not (commitment-aprrl-- consume ?p ?r ?s ?l))
        (fulfillment-aprrl-- consume ?p ?r ?s ?l)
        (increase (total-cost) 1)
    )
)

(:action event-move 
    :parameters (?a - actor ?r - resource ?fromLocation ?toLocation - location)
    :precondition ( and
        (not (isPassive ?a))
        (currentLocation ?r ?fromLocation)
        (currentLocation ?a ?fromLocation)
        (custodian ?r ?a)
        (commitment-aprrlt- move ?a ?a ?r ?fromLocation ?toLocation)
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
        (fulfillment-aprrlt- move ?a ?a ?r ?fromLocation ?toLocation)
        (not (commitment-aprrlt- move ?a ?a ?r ?fromLocation ?toLocation))
        (forall (?t - thing )
            (when 
                (containedIn ?t ?r)
                (and 
                    (currentLocation ?t ?toLocation)
                    (not (currentLocation ?t ?fromLocation))
                )
            )
        )
        (increase (total-cost) 1)
    )
)

(:action event-put-into
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
        (increase (total-cost) 1)
    )
)


(:action event-take-out-of
    :parameters (?a - actor ?r ?rContainer - resource)
    :precondition (and
        (not (isPassive ?a))
        (containedIn ?r ?rContainer)
        (custodian ?rcontainer ?a)
    )
    :effect 
        (and
            (not (containedIn ?r ?rContainer))
            (increase (total-cost) 1)
        )
)


(:action event-mount
    :parameters (?driver ?passenger - actor ?vehicle - resource ?l - location)
    :precondition (and 
        (isVehicle ?vehicle)
        (not (isPassive ?driver))
        (not (isPassive ?passenger))
        (using ?driver ?vehicle)
        (mayContainActors ?vehicle)
        (commitment-aprrl-- mount ?driver ?passenger ?vehicle ?l)            
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
        (fulfillment-aprrl-- mount ?driver ?passenger ?vehicle ?l)           
        (not (commitment-aprrl-- mount ?driver ?passenger ?vehicle ?l)) 
        (increase (total-cost) 1)
    )
)

(:action event-dismount
    :parameters (?driver ?passenger - actor ?vehicle - resource ?l - location)
    :precondition (and 
        (isVehicle ?vehicle)
        (not (isPassive ?driver))
        (custodian ?vehicle ?driver)
        (containedIn ?passenger ?vehicle)
        (currentLocation ?driver ?l)
        (currentLocation ?vehicle ?l)
        (currentLocation ?passenger ?l)
        (commitment-aprrl-- dismount ?driver ?passenger ?vehicle ?l)
    )
    :effect 
        (and
            (not (containedIn ?passenger ?vehicle))
            (not (isPassive ?passenger))
            (fulfillment-aprrl-- dismount ?driver ?passenger ?vehicle ?l)
            (not (commitment-aprrl-- dismount ?driver ?passenger ?vehicle ?l))
            (increase (total-cost) 1)
        )
)

(:action event-begin-use
    :parameters (?a - actor ?r - resource ?l - location)
    :precondition ( and
        (and
            (currentLocation ?r ?l)
            (currentLocation ?a ?l)
            (commitment-aprrl-- use ?a ?a ?r ?l)
        )
        (not (isPassive ?a))
        (custodian ?r ?a)
        (not 
            (exists (?a2 - actor)
                (and 
                    (not (= ?a2 ?a))
                    (using ?a2 ?r)
                )
            )      
        )
    )
    :effect (and
        (using ?a ?r)
        (not (commitment-aprrl-- use ?a ?a ?r ?l))
        (fulfillment-aprrl-- use ?a ?a ?r ?l)
        (increase (total-cost) 1)
    )
)

(:action event-continue-use
    :parameters (?a - actor ?r - resource ?l - location)
    :precondition ( and
        (currentLocation ?r ?l)
        (currentLocation ?a ?l)
        (using ?a ?r)
        (not (isPassive ?a))
        (commitment-aprrl-- use ?a ?a ?r ?l)
    )
    :effect (and
        (not(commitment-aprrl-- use ?a ?a ?r ?l))
        (fulfillment-aprrl-- use ?a ?a ?r ?l)
        (increase (total-cost) 1)
    )
)


(:action event-end-use
    :parameters (?a - actor ?r - resource ?l - location)
    :precondition 
        (and 
            (and
                (currentLocation ?r ?l)
                (currentLocation ?a ?l)
            )
            (using ?a ?r)
            (not (isPassive ?a))
        )
    :effect 
        (and
            (not(using ?a ?r))
            (when 
                (commitment-aprrl-- use ?a ?a ?r ?l)
                (and
                    (not(commitment-aprrl-- use ?a ?a ?r ?l))
                    (fulfillment-aprrl-- use ?a ?a ?r ?l)
                )
            )
            (increase (total-cost) 1)
        )
)

(:action event-transfer-custody
    :parameters (?provider ?receiver - actor ?r - resource ?l - location)
    :precondition (and
        (not (isPassive ?provider))
        (not (isPassive ?receiver))
        (custodian ?r ?provider)
        (not (= ?provider ?receiver))
        (currentLocation ?provider ?l) 
        (currentLocation ?receiver ?l)
        (currentLocation ?r ?l)
        (commitment-aprrl-- transfer-custody ?provider ?receiver ?r ?l) 
        (not (exists (?container - resource) (containedIn ?r ?container)))
    )
    :effect(and
        (not (custodian ?r ?provider))
        (custodian ?r ?receiver)
        (fulfillment-aprrl-- transfer-custody ?provider ?receiver ?r ?l) 
        (not (commitment-aprrl-- transfer-custody ?provider ?receiver ?r ?l) )
        (increase (total-cost) 1)
    )
)

(:action event-transfer-all-rights
    :parameters (?provider ?receiver - actor ?r - resource ?l - location)
    :precondition 
        ( and 
            (primaryAccountable ?r ?provider)
            (not (isPassive ?provider))
            (not (isPassive ?receiver)) ;questionable
            (or 
                (currentLocation ?provider ?l)
                (currentLocation ?receiver ?l)
            )
            (commitment-aprrl-- transfer-all-rights ?provider ?receiver ?r ?l) 
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (fulfillment-aprrl-- transfer-all-rights ?provider ?receiver ?r ?l) 
            (not (commitment-aprrl-- transfer-all-rights ?provider ?receiver ?r ?l) )
            (increase (total-cost) 1)
        )
)

(:action event-transfer
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
            (commitment-aprrl-- transfer ?provider ?receiver ?r ?l) 
            (not (exists (?container - resource) (containedIn ?r ?container)))
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (not (custodian ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (custodian ?r ?receiver)            
            (fulfillment-aprrl-- transfer ?provider ?receiver ?r ?l) 
            (not (commitment-aprrl-- transfer ?provider ?receiver ?r ?l) )
            (increase (total-cost) 1)
        )
)


(:action event-transfer-intangible
    :parameters (?provider - actor ?receiver - actor ?r - intangibleResource)
    :precondition 
        ( and 
            (not (isPassive ?provider))
            (not (isPassive ?receiver))
            (custodian ?r ?provider)
            (primaryAccountable ?r ?provider)
            (commitment-aprr--- transfer ?provider ?receiver ?r) 
        )
    :effect 
        ( and
            (not(primaryAccountable ?r ?provider))
            (not (custodian ?r ?provider))
            (primaryAccountable ?r ?receiver)
            (custodian ?r ?receiver)            
            (fulfillment-aprr--- transfer ?provider ?receiver ?r) 
            (not (commitment-aprr--- transfer ?provider ?receiver ?r ) )
            (increase (total-cost) 1)
        )
)

;------------------------------------------------------------------------------
;
;                    GOAL STATE
;
;------------------------------------------------------------------------------
; we define our goal in general terms: no intents or commitments must be left over
; this trick allows us to use the same goal in all situations

(:action accept-solution
    :parameters ()
    :precondition
    (not 
        (exists (?a - action ?p ?r - actor ?s - resource ?l ?t - location ?c - resourceClassType)
            (or
                (commitment-aprrltc ?a ?p ?r ?s ?l ?t ?c)
                (commitment-aprrlt- ?a ?p ?r ?s ?l ?t)
                (commitment-aprrl-c ?a ?p ?r ?s ?l ?c)
                (commitment-aprrl-- ?a ?p ?r ?s ?l)
                (commitment-aprr--- ?a ?p ?r ?s)
                (intent-aprrltc ?a ?p ?r ?s ?l ?t ?c)
                (intent-aprrlt- ?a ?p ?r ?s ?l ?t)
                (intent-aprrl-c ?a ?p ?r ?s ?l ?c)
                (intent-aprrl-- ?a ?p ?r ?s ?l)
                (intent-apr-lt- ?a ?p ?r ?l ?t)
                (intent-apr-l-c ?a ?p ?r ?l ?c)
                (intent-aprr--- ?a ?p ?r ?s) 
                (intent-apr-l-- ?a ?p ?r ?l)
                (intent-apr---c ?a ?p ?r ?c)
                (intent-ap-rl-- ?a ?p ?s ?l)
                (intent-ap-r--c ?a ?p ?s ?c)
                (intent-ap--l-c ?a ?p ?l ?c)
                (intent-a-rrl-- ?a ?r ?s ?l)
                (intent-a-r-l-c ?a ?r ?l ?c)
                (intent-apr---- ?a ?p ?r)
                (intent-ap-r--- ?a ?p ?s)
                (intent-ap----c ?a ?p ?c)
                (intent-a-r---c ?a ?r ?c)
                (intent-ap----- ?a ?p)
            )
        )
    )
    :effect     
        (and 
            (problemSolved)
            (increase (total-cost) 0)
        )
    
)



;------------------------------------------------------------------------------
;
;                    DEBUGGING
;
;------------------------------------------------------------------------------
; 
; if (debug) is set, these actions will remove intents, hopefully reaching a 
; (problemSolved) state. In that case, the removal actions show up in the solution,
; indicating that there are intents left over that hinder us from getting to 
; the (problemSovled) state

; --------- TRIGGER ACTION(s) ENABLING DEBUGGING ACTIONS
(:action debugtrigger
    :parameters ()
    :precondition (and 
        (debug)
    )
    :effect (and 
        (debugRemoveUnusedCommitments)
        (debugRemoveUnusedIntents)
    )
)


; ----------- DEBUGGING ACTIONS
; help to spot predicates that have to be removed in order to reach the standard goal

(:action remove-intent-aprrltc 
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location ?c - resourceClassType) 
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-aprrltc ?action ?provider ?receiver ?r ?l ?t ?c) 
        )
    :effect (not
        (intent-aprrltc ?action ?provider ?receiver ?r ?l ?t ?c) 
    )
)

(:action remove-intent-aprrlt- 
    :parameters ( ?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-aprrlt- ?action ?provider ?receiver ?r ?l ?t)
        )
    :effect (not
        (intent-aprrlt- ?action ?provider ?receiver ?r ?l ?t)
    )
)

(:action remove-intent-aprrl-c  
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-aprrl-c ?action ?provider ?receiver ?r ?l ?c)
        )
    :effect (not
        (intent-aprrl-c ?action ?provider ?receiver ?r ?l ?c)
    )
)

(:action remove-intent-aprrl-- 
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
             (intent-aprrl-- ?action ?provider ?receiver ?r ?l)
        )
    :effect (not
         (intent-aprrl-- ?action ?provider ?receiver ?r ?l)
    )
)

(:action remove-intent-apr-lt-
    :parameters ( ?action - action ?provider ?receiver - actor ?l ?t - location)    
    :precondition
        (and 
            (debugRemoveUnusedIntents)
             (intent-apr-lt- ?action ?provider ?receiver ?l ?t)    
        )
    :effect (not
        (intent-apr-lt- ?action ?provider ?receiver ?l ?t)    
    )
)

(:action remove-intent-apr-l-c 
    :parameters (?action - action ?provider ?receiver - actor ?l - location ?c - resourceClassType) 
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-apr-l-c ?action ?provider ?receiver ?l ?c) 
        )
    :effect (not
        (intent-apr-l-c ?action ?provider ?receiver ?l ?c) 
    )
)

(:action remove-intent-aprr--- 
    :parameters (?action - action ?provider ?receiver - actor ?r - resource)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-aprr--- ?action ?provider ?receiver ?r)
        )
    :effect (not
        (intent-aprr--- ?action ?provider ?receiver ?r)
    )
)

(:action remove-intent-apr-l-- 
    :parameters (?action - action ?provider ?receiver - actor ?l - location)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-apr-l-- ?action ?provider ?receiver ?l)
        )
    :effect (not
        (intent-apr-l-- ?action ?provider ?receiver ?l)
    )
)

(:action remove-intent-apr---c 
    :parameters (?action - action ?provider ?receiver - actor ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-apr---c ?action ?provider ?receiver ?c)
        )
    :effect (not
        (intent-apr---c ?action ?provider ?receiver ?c)
    )
)

(:action remove-intent-ap-rl-- 
    :parameters (?action - action ?provider - actor ?r - resource ?l - location)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-ap-rl-- ?action ?provider ?r ?l)
        )
    :effect (not
        (intent-ap-rl-- ?action ?provider ?r ?l)
    )
)

(:action remove-intent-ap-r--c 
    :parameters (?action - action ?provider - actor ?r - resource ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-ap-r--c ?action ?provider ?r ?c)
        )
    :effect (not
        (intent-ap-r--c ?action ?provider ?r ?c)
    )
)

(:action remove-intent-ap--l-c 
    :parameters (?action - action ?provider - actor ?l - location ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-ap--l-c ?action ?provider ?l ?c)
        )
    :effect (not
        (intent-ap--l-c ?action ?provider ?l ?c)
    )
)

(:action remove-intent-a-rrl-- 
    :parameters (?action - action ?receiver - actor ?r - resource ?l - location)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
             (intent-a-rrl-- ?action ?receiver ?r ?l)
        )
    :effect (not
         (intent-a-rrl-- ?action ?receiver ?r ?l)
    )
)

(:action remove-intent-a-r-l-c 
    :parameters (?action - action ?receiver - actor ?l - location ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-a-r-l-c ?action ?receiver ?l ?c)
        )
    :effect (not
        (intent-a-r-l-c ?action ?receiver ?l ?c)
    )
)


(:action remove-intent-apr---- 
    :parameters (?action - action ?provider ?receiver - actor )
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-apr---- ?action ?provider ?receiver )
        )
    :effect (not
        (intent-apr---- ?action ?provider ?receiver )
    )
)


(:action remove-intent-ap-r---
    :parameters ( ?action - action ?provider - actor ?r - resource)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
             (intent-ap-r--- ?action ?provider ?r)
        )
    :effect (not
         (intent-ap-r--- ?action ?provider ?r)
    )
)


(:action remove-intent-ap----c
    :parameters (?action - action ?provider - actor ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-ap----c ?action ?provider ?c)
        )
    :effect (not
        (intent-ap----c ?action ?provider ?c)
    )
)


(:action remove-intent-a-rr--- 
    :parameters (?action - action ?receiver - actor ?r - resource)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-a-rr--- ?action ?receiver ?r)
        )
    :effect (not
        (intent-a-rr--- ?action ?receiver ?r)
    )
)


(:action remove-intent-a-r---c 
    :parameters (?action - action ?receiver - actor ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-a-r---c ?action ?receiver ?c)
        )
    :effect (not
        (intent-a-r---c ?action ?receiver ?c)
    )
)

(:action remove-intent-ap----- 
    :parameters (?action - action ?provider - actor)
    :precondition
        (and 
            (debugRemoveUnusedIntents)
            (intent-ap----- ?action ?provider)
        )
    :effect (not
        (intent-ap----- ?action ?provider)
    )
)



(:action remove-commitment-aprrltc 
    :parameters (?action - action ?provider ?receiver - actor ?s - resource ?l ?t - location ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedCommitments)
            (commitment-aprrltc ?action ?provider ?receiver ?s ?l ?t ?c)
        )
    :effect (not
        (commitment-aprrltc ?action ?provider ?receiver ?s ?l ?t ?c) 
    )
)

(:action remove-commitment-aprrlt- 
    :parameters (?action - action ?provider ?receiver - actor ?r - resource ?l ?t - location)
    :precondition
        (and 
            (debugRemoveUnusedCommitments)
            (commitment-aprrlt- ?action ?provider ?receiver ?r ?l ?t)
        )
    :effect (not
        (commitment-aprrlt- ?action ?provider ?receiver ?r ?l ?t)    
    )
)

(:action remove-commitment-aprrl-c
    :parameters ( ?action - action ?provider ?receiver - actor ?s - resource ?l - location ?c - resourceClassType)
    :precondition
        (and 
            (debugRemoveUnusedCommitments)
            (commitment-aprrl-c ?action ?provider ?receiver ?s ?l ?c)
        )
    :effect (not
        (commitment-aprrl-c ?action ?provider ?receiver ?s ?l ?c)
    )
)

(:action remove-commitment-aprrl--
    :parameters ( ?action - action ?provider ?receiver - actor ?r - resource ?l - location)
    :precondition
        (and 
            (debugRemoveUnusedCommitments)
            (commitment-aprrl-- ?action ?provider ?receiver ?r ?l)   
        )
    :effect (not
        (commitment-aprrl-- ?action ?provider ?receiver ?r ?l)
    )
)

(:action remove-commitment-aprr--- 
    :parameters (?action - action ?provider ?receiver - actor ?r - intangibleResource)
    :precondition
        (and 
            (debugRemoveUnusedCommitments)
            (commitment-aprr--- ?action ?provider ?receiver ?r)
        )
    :effect (not
        (commitment-aprr--- ?action ?provider ?receiver ?r)
    )
)

)
