execute if score colorCode wtmsbTmp matches 160 run data merge entity @s {Particle: "minecraft:dust 0.8000 0.4000 0.4000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 160 run function wtmsb:private/colors/173
