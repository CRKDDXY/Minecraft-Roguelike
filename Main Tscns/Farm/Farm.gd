extends Node2D

@export var player : CharacterBody2D #玩家对象
@export var Inventory : GridContainer #主背包节点
@export var hand : Node2D #玩家手部持有物对象->这里的是用来做使用工具动画的

@export var Dirt : GridContainer #土地集群
@export var Jungle : GridContainer #丛林木集群
@export var Soul_Sand : GridContainer #灵魂沙集群

func _ready():
	get_window().mode = Window.MODE_FULLSCREEN #全屏模式
	player.move_speed = 60 #玩家在农田的移动速度
	for i in range(player.skills.get_child_count()):
		player.skills.get_child(i).queue_free() #去除玩家技能
	_dirts_child_connect() #耕地子节点信号连接，用于检测玩家当前选中的土地
	_Inventory_Choose_Item() #背包物品连接信号，用于选中背包物品逻辑

func _process(_delta):
	#使用物品
	if Input.is_action_just_pressed("use_hand_item"):
		#手部动画逻辑
		if hand.rotation_degrees != -25:
			hand.rotation_degrees = -25
		var tween = hand.create_tween()
		tween.tween_property(hand,"rotation_degrees",15,0.1)
		tween.tween_property(hand,"rotation_degrees",-25,0.1)
		if Choose_Dirt != null: #还是得先判断是否选中了某个土地，防止指针滞空导致游戏崩溃
			_dirt_with_player_hand()
		await tween.finished
		tween.kill()
		#如果选中了某个耕地，对该耕地进行逻辑判定，判定对象为（耕地+玩家手持物品）
		#其他操作逻辑

	#开关背包
	if Input.is_action_just_pressed("Open_Inventory"):
		Inventory.get_node("../..").visible = !Inventory.get_node("../..").visible

#耕地子节点信号连接，用于检测玩家当前选中的土地
func _dirts_child_connect():
	var DD : Array[GridContainer] = [Dirt,Jungle,Soul_Sand]
	for D in DD: #获取土地节点
		for one_of_dirt_index in range(D.get_child_count()):
			D.get_child(one_of_dirt_index).Player_Choose.body_entered.connect(_Player_Choose_The_One_Dirt.bind(D.get_child(one_of_dirt_index)))
			D.get_child(one_of_dirt_index).Player_Choose.body_exited.connect(_Player_release_The_One_Dirt.bind(D.get_child(one_of_dirt_index)))
var Choose_Dirt : TextureRect #被选中的土地对象
#选取
func _Player_Choose_The_One_Dirt(_body : Node2D , dirt_self : TextureRect):
	dirt_self.modulate = Color8(255,170,170)
	Choose_Dirt = dirt_self
#释放
func _Player_release_The_One_Dirt(_body : Node2D , dirt_self : TextureRect):
	dirt_self.modulate = Color8(255,255,255)
	if Choose_Dirt == dirt_self: #要是相同的就可以滞空，要是不同，说明游戏帧中是先接触了新的土地，再离开了旧的土地，太快就会导致被选中滞空的情况
		Choose_Dirt = null

#背包物品连接信号，用于选中背包物品逻辑
func _Inventory_Choose_Item():
	#Inventory指向的是背包集群
	for Slot_index in range(Inventory.get_child_count()):
		Inventory.get_child(Slot_index).pressed.connect(_Choose_Item_Mouse_Pressed.bind(Inventory.get_child(Slot_index)))

@export var hand_item_type : Sprite2D #修改手部物品贴图

func _Choose_Item_Mouse_Pressed(Item_Slot : TextureButton):
	if Item_Slot.Item_Type != "":
		hand_item_name = Item_Slot.Item_Type #修改该脚本的手持物品的名称，用于下面方法的使用逻辑
		hand_item_type.texture = load(Item_Slot.Item_Textures[Item_Slot.Item_Type]) #修改手部物品贴图
	else:
		hand_item_type.texture = null #去除手部物品

@export var hand_item_name : String #玩家手部持有物对象

#物品+土地的使用逻辑
func _dirt_with_player_hand():
	#土地指针：Choose_Dirt : TextureRect -> One Dirt.gd / .tscn #大对象，整个土地，需要获取子节点进行操作
	#手部物品指针：hand_item_name : String -> 物品名称
	if hand_item_name != null:
		match(hand_item_name):
			"wooden_hoe": #锄头
				if Choose_Dirt.type == "dirt":
					Choose_Dirt._set_dirt_type("farmland")
			"water_bucket": #水桶
				if Choose_Dirt.type == "farmland":
					Choose_Dirt._set_dirt_type("farmland_moist")
			"wheat_seed": #小麦种子
				if Choose_Dirt.type == "farmland_moist": #湿土地
					if Choose_Dirt.Is_Crop_growing == false: #没有正在生长中的作物
						Choose_Dirt._set_crop_type(hand_item_name) #播种逻辑
			"cocoa_beans": #可可豆
				if Choose_Dirt.type == "jungle_log": #从林木
					if Choose_Dirt.Is_Crop_growing == false: #没有正在生长中的作物
						Choose_Dirt._set_crop_type(hand_item_name) #播种逻辑
			"nether_wart": #地狱庞
				if Choose_Dirt.type == "soul_sand": #灵魂沙
					if Choose_Dirt.Is_Crop_growing == false: #没有正在生长中的作物
						Choose_Dirt._set_crop_type(hand_item_name) #播种逻辑
