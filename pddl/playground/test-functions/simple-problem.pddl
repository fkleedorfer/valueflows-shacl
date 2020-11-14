(define 
    (problem test) 
    (:domain quanttest)
    (:objects 
        res1 res2 - resource
    )

    (:init
        (assign (quantity ?res1) 5)
        (assign (quantity ?res2) 3)
    )
    (:goal
    (= (quantity ?res1) 8)
    )
)