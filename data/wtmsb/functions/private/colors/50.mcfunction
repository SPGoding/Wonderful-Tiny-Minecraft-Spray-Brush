execute if score colorCode wtmsbTmp matches 15 run data merge entity @s {Particle: "minecraft:dust 0.0000 0.4000 0.4000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 15 run function wtmsb:private/colors/51
