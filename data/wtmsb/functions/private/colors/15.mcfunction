execute if score colorCode wtmsbTmp matches 95 run data merge entity @s {Particle: "minecraft:dust 0.4000 0.6000 0.6000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 95 run function wtmsb:private/colors/16
