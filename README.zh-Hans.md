# Wonderful Tiny Minecraft Spray Brush
# Minecraft 超赞的轻量级喷漆系统

# 简介

超赞的轻量级喷漆系统（Wonderful Tiny Minecraft Spray Brush）是一个原版模组，提供了将任意图片变为喷漆，并让玩家将其喷在游戏内的功能。

![good.png](https://i.loli.net/2019/10/08/WE7jsLgxkHcrYBe.png)

# 原理

## 喷漆图片的保存

众所周知，颜色可以由 RGBA 四个通道来表示。本模组使用 [216 色](https://www.colorhexa.com/web-safe-colors)以及透明色共 217 个颜色来表示每一个喷漆。这 217 个颜色每一个都被赋予了一个颜色代码，其中 `0` 表示透明色。

所有喷漆的数据都储存在 `wtmsb:` 这一 data storage 中。`wtmsb:` 是一个复合标签，其格式如下：

- <喷漆数字标识>-<喷漆英文名>: (list)
    - (short): 该喷漆的宽度 - 1，单位为像素。
    - (short): 该喷漆的高度 - 1，单位为像素。
    - (short): 该喷漆位于 (0, 0) 位置的像素的颜色代码。
    - (short): 该喷漆位于 (1, 0) 位置的像素的颜色代码。
    - ...

从第三项开始的数据是以图片的左上角为起点，按 “2” 形将像素对应的颜色代码存储到列表中所产生的。

例如，以下命令定义了样式为 MCBBS「优秀」图标的喷漆：

```mcfunction
data modify storage wtmsb: {} merge value {2-good:[24s,13s,0s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,0s,145s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,145s,145s,0s,0s,0s,145s,0s,0s,0s,145s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,145s,145s,145s,0s,0s,145s,145s,0s,0s,0s,0s,0s,145s,145s,145s,145s,145s,0s,0s,0s,145s,0s,145s,0s,0s,0s,145s,0s,0s,0s,145s,145s,0s,0s,145s,0s,0s,0s,0s,145s,0s,0s,0s,0s,0s,0s,0s,0s,145s,0s,0s,0s,0s,0s,0s,145s,145s,0s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,0s,145s,145s,145s,145s,145s,145s,145s,0s,145s,0s,0s,145s,145s,0s,145s,145s,0s,0s,0s,0s,145s,0s,0s,0s,0s,0s,145s,0s,0s,145s,0s,0s,145s,0s,0s,0s,145s,145s,0s,145s,145s,0s,145s,145s,145s,145s,145s,0s,145s,0s,0s,0s,145s,0s,145s,0s,0s,0s,145s,0s,0s,145s,145s,0s,0s,145s,0s,0s,0s,145s,0s,145s,0s,0s,0s,0s,0s,0s,145s,0s,0s,145s,0s,0s,0s,0s,145s,145s,0s,0s,145s,145s,145s,0s,0s,145s,0s,0s,0s,0s,145s,0s,145s,0s,145s,0s,0s,0s,145s,0s,0s,145s,145s,0s,0s,145s,0s,0s,145s,0s,0s,145s,0s,145s,0s,0s,0s,145s,0s,0s,0s,0s,0s,145s,0s,0s,145s,145s,0s,0s,0s,145s,145s,145s,0s,0s,0s,145s,145s,0s,145s,145s,145s,0s,0s,0s,145s,0s,145s,0s,0s,145s,145s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,0s,145s,0s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,145s,0s,]}
```

其中前两个数字（`24s, 13s`）表示该喷漆的大小为 25 × 14，后续数字中 `0s` 表示该像素透明，`145s` 表示该像素为红色。

![image.png](https://i.loli.net/2019/10/08/TCdbqDnEuF7Oc4J.png)

所有的喷漆都在函数 `wtmsb:private/image_data` 中定义。该函数通常是脚本生成的，不需要手动修改。

## 喷漆图片的读取

### 复制 buffer

将该喷漆对应的列表使用 `data modify` 命令移动到 `wtmsb:` storage 的 `buffer` 下：

```
data modify storage wtmsb: buffer set from storage wtmsb: x-xxxxxx
```

这一步位于函数 `wtmsb:private/copy_buffer` 中。该函数通常是脚本生成的，不需要手动修改。

### 获取喷漆大小

通过 `storage wtmsb: buffer` 中的前两个数字获取该喷漆的大小，进而决定下一步中函数遍历的次数。读取完成后，这两个数字会被删除。

这一步位于函数 `wtmsb:private/set_buffer` 中。我已经写好了，不需要手动修改。

### 为喷漆的每一个像素生成 marker

执行函数 `wtmsb:private/summon_at_each_point`。该函数是一个不断递归的函数，它所做的内容是：

1. 获取并删除当前 `storage wtmsb: buffer` 中的第 `[0]` 项。该数字表示的是这个像素的颜色代码。
2. 如果颜色代码不是 `0`（不是透明色），则在当前位置生成一个含有 `wtmsb_spray` 标签 marker，并把颜色代码存到 marker 的 `wtmsbTmp` 分数中。此外，将玩家的朝向数据储存到该 marker 的 `wrnmd_x0`、`wrnmd_y0`、`wrnmd_z0` 分数中，这是「家门边的超棒射线追踪系统」提供的用于超精确方块判定的调用接口。
3. 根据之前获取的该喷漆的大小，决定是否继续递归执行，以及在递归前通过 `execute positioned` 进行的坐标偏移量。

至此，储存在 `storage wtmsb: buffer` 中的喷漆数据已经转化为了一个由 `tag=wtmsb_spray` 的 marker 构成的实体阵。

## 玩家喷漆的处理

当玩家发动「喷漆」后，首先将执行坐标向玩家左上方偏移喷漆大小的一半，使喷出来的喷漆能够相对于玩家指针居中。

然后，执行上述「喷漆图片的读取」的步骤。

接下来就应当在每个 `tag=wtmsb_spray` 的 marker 的位置进行方块碰撞判定。由于该判定极其精细，执行命令数略多，我们可以限制每刻执行的 marker 数量为 10 个。为了使得效果更为自然，首先以每个玩家所在位置为执行位置，标记最近的 16 个 `tag=wtmsb_spray` 为 `tag=wtmsb_pre_changing_spray`。然后，从所有 `tag=wtmsb_pre_changing_spray` 中随机抽取 10 个标记为 `tag=wtmsb_changing_spray`。以最终标记的这 10 个实体为执行者，运行 `wrnmd:generic/start` 函数，完成方块判定。

但是，由于 MC 的一个漏洞，对药水云进行位置变换操作并不一定会显示出来，因此最后我们还需要在所有 `tag=wtmsb_changing_spray` 的原地复制一个新的 marker 出来，删除原有的旧 marker。为了区分，新生成的 marker 标记为 `tag=wtmsb_paint`。

最后，修改所有新生成的 `tag=wtmsb_paint` 的 `Particle` 属性，使得它们能够显示出对应颜色代码颜色的粒子。这一步由 `wtmsb:private/colors/` 中的 216 个函数执行。这 216 个函数内容相似，以 `wtmsb:private/colors/1` 为例：

```mcfunction
execute if score colorCode wtmsbTmp matches 145 run data merge entity @s {Particle: "minecraft:dust 0.8000 0.0000 0.0000 0.28", Radius: 0.02f}
execute unless score colorCode wtmsbTmp matches 145 run function wtmsb:private/colors/2
```

可以发现，名为 `1` 的函数对应的颜色代码并不是 `1`，而是 `145`。这是因为在所有喷漆中颜色为 `145` 的像素数量最多，将该颜色放在第一个函数中能有效减少命令的执行数。

# 安装

[attach]1400871[/attach]

[attach]1400870[/attach]

0. 安装本模组的前置模组：[家门边的超棒射线追踪系统](https://www.mcbbs.net/thread-919112-1-1.html)
1. 将 `WTMSB-Data-Pack.zip` 放置在存档的 `datapacks` 目录下；
2. 重进游戏，或输入 `reload` 命令；
3. 将 `WTMSB-Resource-Pack.zip` 放置在 `.minecraft` 文件夹的 `resourcepacks` 目录下；
4. 在「资源包」选项中启用该资源包。

# 使用

该模组没有提供适合生存玩家的获得方法，也没有提供方便的切换喷漆的方式，发布出来仅作为前置模组，可供有兴趣的小游戏地图作者使用。

喷漆罐可以通过命令 `/loot give @s loot wtmsb:spray_can` 获得。拿着喷漆罐对地面/墙面/天花板右键可以喷出喷漆。

喷漆可以通过命令 `/scoreboard players set @s wtmsbType <喷漆 ID>` 切换。

# 添加新喷漆

1. 将 `png` 格式的图片放置在 `data/scripts/image/` 目录下，文件命名为 `<喷漆 ID>-<喷漆名>.png`。`<喷漆 ID>` 必须大于等于 1，必须是整数；
2. 运行脚本 `data/scripts/image/paint.py`。

# 可能的不兼容

本模组使用到的 `CustomModelData` 为 `55130267`，修改了胡萝卜钓竿的模型 `minecraft:item/carrot_on_a_stick`，资源包命名空间为 `wtmsb`。

# 鸣谢

- @kongbaiyo 帮我写的脚本。本模组的前置、世界第一的 [家门边的超棒射线追踪系统](https://www.mcbbs.net/thread-919112-1-1.html) 模组也是他写的。空白白超棒！
- @562256851 帮我画的喷漆罐材质！
- #Overwatch 让我嫖来了喷漆的音效！
