(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Apples - resource
    Rossatz Krems Wien Gedersdorf - location
    Rolf Alice Bob Claudia Maria - actor
    GrannySmith - resourceClassType
    Truck1 - truck
    Car1 - car 
    Anything - resourceClassType
)

(:init
    (currentLocation Bob Wien)
    (intent-a-r-lc transfer-custody Bob Wien Anything)
)
(:goal
   (problemSolved)
)

(:metric minimize (total-cost))
)
