breed [ suns sun ]

breed [ fishes fishe]

breed [ birds bird]

breed [ leaves leaf ]


to setup

  clear-all

  set-default-shape suns "circle"

  set-default-shape fishes "fish"

  set-default-shape birds "hawks"

  env-setup

  swim-fish

  generate-birds

  reset-ticks

end


to generate-birds

    create-birds 20 [

    setxy -20 + (random (-10 + 20) + 1)  (-5 + (random (-5 + 10 + 1)))

  ]

end


to env-setup

  ask patches

  [

    set pcolor blue + 2

    if (pycor < -9 )

      [set pcolor blue]

  ]

  ask patches with [ pxcor < -12 and (pxcor >= -17 and pycor < -7) and pycor >= -9] 

  [

      set pcolor green

  ]


 ask patches with 

  [

    pxcor = -15 and pycor >= -8 and pycor <= 8

    or

    abs (pxcor + 15) = (pycor + 2) and pycor < 4 or

    abs (pxcor + 15) = (pycor + 8) and pycor < 3

  ] [

    set pcolor brown

  ]


  ;; Create the sun

  create-suns 1 [

    setxy (max-pxcor - 2) (max-pycor - 3)

    ;; change appearance based on intensity

    set color yellow

    set size 4

  ]

end


to swim-fish

  create-fishes 20 [

   setxy random 23 - 11 random 10 - 20

   set heading 90

  ]

end


to marches
  ask fishes [
    fd 0.1
 ]
  move-birds 
 tick
end

to move-birds 
  ask one-of birds [
    set heading 180
    right random 100
    left random 100
    fd 10 
    if 
  ]
end