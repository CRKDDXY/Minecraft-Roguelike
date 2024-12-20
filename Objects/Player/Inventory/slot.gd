extends TextureButton

var Item_Type : String #物品名称
var Number : int #物品个数

@export var Item_Texture : Sprite2D #物品对应的贴图
@export var Number_Text : Label #物品个数

var Item_Textures = {
	"wheat_seed" : "res://Objects/Farm/Crops/Wheat/wheat_seeds.png", #小麦种子
	"water_bucket" : "res://Objects/Player/Inventory/Items/water_bucket.png", #水桶
	"wooden_hoe" : "res://Objects/Player/Inventory/Items/Hoe/wooden_hoe.png", #木锄
	"cocoa_beans" : "res://Objects/Farm/Crops/Cocoa/cocoa_beans.png", #可可豆
	"nether_wart" : "res://Objects/Farm/Crops/Nether Wart/nether_wart.png" #地狱庞
}

func _ready():
	Item_Texture.texture = null
	Number_Text.text = ""

func _set_Item(Item_Name : String):
	Item_Type = Item_Name
	Number = 1
	_update_Number_Text()#更新数量
	_update_Item_Texture()#更新物品图标

#增减物品数量
func _set_Item_Number(Change_Number : int):
	Number += Change_Number
	_update_Number_Text() #更新数量

#更新数量
func _update_Number_Text():
	Number_Text.text = (str(Number))

#更新物品图标
func _update_Item_Texture():
	Item_Texture.texture = load(Item_Textures[Item_Type])
