globals [
  fish-eaten          ;; To track the number of fish eaten by birds
  fish-eating-cycle   ;; To track the number of ticks passed in a cycle
  fish-count
]

birds-own [
  food-consumed  ;; La quantité de poissons consommée aujourd'hui
  day-counter    ;; Compte le nombre de ticks dans une journée
]

breed [ suns sun ]

breed [ fishes fishe]

breed [ birds bird]

breed [ leaves leaf ]


to setup
  clear-all
  set fish-eaten 0
  set fish-eating-cycle 0

  set-default-shape suns "circle"
  set-default-shape fishes "fish"
  
  env-setup
  swim-fish
  generate-birds
  reset-ticks
end



to generate-birds

create-birds 1 [

setxy -20 + (random (-10 + 20) + 1) (-5 + (random (-5 + 10 + 1)))
  set food-consumed 0  ;; Initialiser la consommation des oiseaux à 0
  set day-counter 0    ;; Compteur de ticks dans la journée

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

create-fishes 11 [

setxy random 23 - 11 random 10 - 20

set heading 90

]

end


to marches
  set fish-count count fishes
ask fishes [
fd 0.1
]
move-birds
tick
end

to move-birds
    ask birds [
        if food-consumed < 5
  [
    let target-fish one-of fishes with [distance myself < 50]  ;; Select a nearby fish
    
    if target-fish != nobody [
      face target-fish  ;; Orient the bird towards the fish
      forward 1 + random 3  ;; Move towards the fish

      ;; Check if the fish is close enough to be eaten
      if distance target-fish < 1 [
        ask target-fish [ die ]  ;; Eat the fish
        set fish-eaten fish-eaten + 1  ;; Increment the fish eaten counter
        set food-consumed food-consumed + 1 
        ;; After eating, the bird returns to a random position
        setxy (-20 + random 20)  -5 + random 10
        if size < 2 [ set size size + 0.15 ]
      ]
    ]
      ]
  if food-consumed >= 5 [
      ;; L'oiseau a mangé 10 poissons aujourd'hui, il ne mangera plus aujourd'hui
      set food-consumed 5
       ;; Cap sur la consommation maximale (10 poissons)
    	setxy (-20 + random 20)  -5 + random 10
    ]
  if day-counter mod 180 = 0 [  ;; Une journée = 24 ticks
    set food-consumed 0  ;; Réinitialiser la consommation à la fin de la journée
     ;; Réinitialiser le compteur de la journée   
    ]
  	if day-counter = 1260 [  ;; Si 7 jours (1260 ticks) ont passé
      generate-fish   ;; Générer 10 poissons supplémentaires
     
    ]
  ]
  ;; Update the cycle and regenerate fish if needed
  if day-counter mod 1260 = 0 [  ;; Si 7 jours (1260 ticks) ont passé
      generate-fish   ;; Générer 10 poissons supplémentaires
     
    ]
end

to generate-fish
  let fish-to-create 10  ;; Number of new fish to create
  create-fishes fish-to-create [
    setxy random 23 - 11 random 10 - 20
    set heading 90  ;; Random initial heading
]
end
