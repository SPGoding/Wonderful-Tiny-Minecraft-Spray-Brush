execute if score colorCode wtmsbTmp matches 128 run data merge entity @s {Particle: "minecraft:dust 0.6000 0.6000 0.6000 0.28", Radius: 0.02f}
execute unless score colorCode wtmsbTmp matches 128 run function wtmsb:private/colors/17
