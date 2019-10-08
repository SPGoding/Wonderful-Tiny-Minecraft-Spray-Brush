#> wtmsb:tick

execute as @a unless score @s wtmsbUid matches 0.. run function wtmsb:private/get_uid
execute as @a unless score @s wtmsbType matches 1.. run scoreboard players set @s wtmsbType 1

execute as @a[scores={wtmsbClick=1..},predicate=wtmsb:is_spraying] at @s run function wtmsb:paint

execute as @a if score @s wtmsbCool matches 1.. run scoreboard players remove @s wtmsbCool 1

scoreboard players reset * wtmsbClick
