; this is just to test if fast-downward can handle numeric functions. it cannot.
(define 
    (domain quanttest)
    (:requirements :adl :typing)
    (:types resource action)
    (:constants transfer - action)
    (:functions (quantity - numeric ?r - resource))
    (:action transfer
        :parameters (?from ?to - resource ?amount - numeric)
        :precondition ( >= (quantity ?from) ?amount)
        :effect (
            (and
                (increase (quantity ?to) ?amount)
                (decrease (quantity ?from) ?amount)
            )
        )
    )
)