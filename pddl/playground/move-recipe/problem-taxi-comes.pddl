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
    (persistent-intent-ap-r-c deliver-service Maria Car1 TaxiServiceClass)
    ;(persistent-intent-apr--- travel Maria Maria)

    (currentlocation Claudia Horn)
    (intent-apr-l- travel Claudia Claudia Wien)

    (currentlocation Rolf Krems)
    (intent-apr-l- travel Rolf Rolf Linz)
    
)
    
(:goal 
    (problemSolved)
)


(:metric minimize (total-cost))
)
