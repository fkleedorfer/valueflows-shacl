(define 
    (problem simple-move) 
    (:domain valueflows)
(:objects 
    Wien Krems Horn Linz - location
    Claudia Maria Rolf - actor
    Car1 - car 
)

(:init
    (currentLocation Maria Krems)
    (currentLocation Car1 Krems)
    (custodian Car1 Maria)
    (isVehicle Car1)
    (mayContainActors Car1)
    (persistent-intent-ap-r--c deliver-service Maria Car1 TaxiServiceClass)

    (currentlocation Claudia Horn)
    (intent-apr-lt- travel Claudia Claudia Horn Wien)

    (currentlocation Rolf Krems)
    (intent-apr-lt- travel Rolf Rolf Krems Linz)
    
)
    
(:goal 
    (problemSolved)
)


(:metric minimize (total-cost))
)
