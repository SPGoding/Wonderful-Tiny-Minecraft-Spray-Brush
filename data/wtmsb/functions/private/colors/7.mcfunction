execute if score colorCode wtmsbTmp matches 50 run data merge entity @s {Particle: "minecraft:dust 0.2000 0.4000 0.4000 0.28", Radius: 0.02f}
execute unless score colorCode wtmsbTmp matches 50 run function wtmsb:private/colors/8
