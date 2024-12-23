extends TextureRect

var crop_stage : Dictionary  = {
	"wheat_seed" : [
		"res://Objects/Farm/Crops/Wheat/wheat_stage0.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage1.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage2.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage3.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage4.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage5.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage6.png",
		"res://Objects/Farm/Crops/Wheat/wheat_stage7.png"
	],
	"Sweet Berry Bush" : [
		'res://Objects/Farm/Crops/Sweet Berry Bush/sweet_berry_bush_stage0.png',
		'res://Objects/Farm/Crops/Sweet Berry Bush/sweet_berry_bush_stage1.png',
		'res://Objects/Farm/Crops/Sweet Berry Bush/sweet_berry_bush_stage2.png',
		'res://Objects/Farm/Crops/Sweet Berry Bush/sweet_berry_bush_stage3.png'
	],
	"Potatoes" : [
		'res://Objects/Farm/Crops/Potatoes/potatoes_stage0.png',
		'res://Objects/Farm/Crops/Potatoes/potatoes_stage1.png',
		'res://Objects/Farm/Crops/Potatoes/potatoes_stage2.png',
		'res://Objects/Farm/Crops/Potatoes/potatoes_stage3.png',
	],
	"nether_wart" : [
		'res://Objects/Farm/Crops/Nether Wart/nether_wart_stage0.png',
		'res://Objects/Farm/Crops/Nether Wart/nether_wart_stage1.png',
		'res://Objects/Farm/Crops/Nether Wart/nether_wart_stage2.png'
	],
	"Carrots" : [
		'res://Objects/Farm/Crops/Carrots/carrots_stage0.png',
		'res://Objects/Farm/Crops/Carrots/carrots_stage1.png',
		'res://Objects/Farm/Crops/Carrots/carrots_stage2.png',
		'res://Objects/Farm/Crops/Carrots/carrots_stage3.png'
	],
	"Beetroots" : [
		'res://Objects/Farm/Crops/Beetroots/beetroots_stage0.png',
		'res://Objects/Farm/Crops/Beetroots/beetroots_stage1.png',
		'res://Objects/Farm/Crops/Beetroots/beetroots_stage2.png',
		'res://Objects/Farm/Crops/Beetroots/beetroots_stage3.png'
	],
	"cocoa_beans" : [
		'res://Objects/Farm/Crops/Cocoa/cocoa_stage0.png',
		'res://Objects/Farm/Crops/Cocoa/cocoa_stage1.png',
		'res://Objects/Farm/Crops/Cocoa/cocoa_stage2.png'
	]
}

#耕地类型对应的土地图片
var dirt_type = {
	"dirt" : "res://Objects/Farm/Lands/dirt.png", #普通泥土地，不可种植的
	"farmland" : "res://Objects/Farm/Lands/farmland.png", #开垦过的普通泥土地，但是没有水，还是不可种植的
	"farmland_moist" : "res://Objects/Farm/Lands/farmland_moist.png", #开垦过，并且有水的耕地，可种植的
	"jungle_log" : "res://Objects/Farm/Lands/jungle_log.png", #从林木，用于种植可可豆
	"soul_sand" : "res://Objects/Farm/Lands/soul_sand.png" #灵魂沙，用于种植地狱庞
}

#作物生长每阶段周期 / s
var crops_update_stage_wait_time = {
	"wheat_seed" : 5, #小麦
	"Sweet Berry Bush" : 1, #浆果
	"Potatoes" : 1, #土豆
	"nether_wart" : 1, #地狱庞
	"Carrots" : 1, #土豆
	"Beetroots" : 1, #甜菜
	"cocoa_beans" : 1 #可可豆
}

@export var dirt : Sprite2D #耕地贴图
@export var crop : Sprite2D #作物贴图
@export var update_timer : Timer #生长计时器

@export var Player_Choose : Area2D #玩家交互碰撞

var type : String #初始化种子类型
var stage : int = 0 #初始化种植阶段

var crop_type : String #作物名字/类型

#作物阶段更新
func _on_timer_timeout():
	#此处调用的是作物阶段贴图路径
	if stage < crop_stage[crop_type].size() - 1:
		stage += 1
		crop.texture = load(crop_stage[crop_type][stage])
	else:
		update_timer.stop()

#设置土地类型
func _set_dirt_type(change_type : String) -> void:
	type = change_type
	dirt.texture = load(dirt_type[type])

var Is_Crop_growing : bool = false #作物是否在生长中

#设置作物类型，播种
func _set_crop_type(crop_name : String) -> void:
	Is_Crop_growing = true
	crop_type = crop_name #设置作物名称/类型
	crop.texture = load(crop_stage[crop_name][0]) #播种下，设置为第一阶段
	update_timer.wait_time = crops_update_stage_wait_time[crop_name] #设置作物的生长周期
	update_timer.start()
