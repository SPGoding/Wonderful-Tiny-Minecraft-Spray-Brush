execute if score colorCode wtmsbTmp matches 45 run data merge entity @s {Particle: "minecraft:dust 0.2000 0.2000 0.2000 0.28", Radius: 0.01f}
execute unless score colorCode wtmsbTmp matches 45 run function wtmsb:private/colors/79
