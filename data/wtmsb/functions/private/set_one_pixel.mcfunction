#> wtmsb:private/set_one_pixel
# @params
# - xRotation wtmsbTmp
# - yRotation wtmsbTmp
# - zRotation wtmsbTmp

# Summon.
summon minecraft:area_effect_cloud ~ ~ ~ {Tags: ["newly_summoned", "wrnmd_bullet", "wtmsb_paint"], CustomName: '"WTMSB paint"', Duration: 1000, Color: -1}

scoreboard players operation @e[tag=newly_summoned] wtmsbUid = @s wtmsbUid

# Set color.
execute as @e[tag=newly_summoned,limit=1,distance=..0.01,type=minecraft:area_effect_cloud] run function wtmsb:private/colors/0

# Do an ray trancing.
scoreboard players operation @e[tag=newly_summoned,limit=1,distance=..0.01,type=minecraft:area_effect_cloud] wrnmd_x0 = xRotation wtmsbTmp
scoreboard players operation @e[tag=newly_summoned,limit=1,distance=..0.01,type=minecraft:area_effect_cloud] wrnmd_y0 = yRotation wtmsbTmp
scoreboard players operation @e[tag=newly_summoned,limit=1,distance=..0.01,type=minecraft:area_effect_cloud] wrnmd_z0 = zRotation wtmsbTmp
execute as @e[tag=newly_summoned,limit=1,distance=..0.01,type=minecraft:area_effect_cloud] at @s run function wrnmd:generic/start

# Checkout.
tag @e remove newly_summoned
