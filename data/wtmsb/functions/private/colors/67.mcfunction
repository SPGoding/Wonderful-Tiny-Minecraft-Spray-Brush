execute if score colorCode wtmsbTmp matches 32 run data merge entity @s {Particle: "minecraft:dust 0.0000 1.0000 1.0000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 32 run function wtmsb:private/colors/68
