execute if score colorCode wtmsbTmp matches 6 run data merge entity @s {Particle: "minecraft:dust 0.0000 0.0000 0.0000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 6 run function wtmsb:private/colors/42
