extends GridContainer

var land_type = {
	"Dirt" : "dirt", #泥土
	"Jungle" : "jungle_log", #从林木
	"Soul Sand" : "soul_sand" #灵魂沙
}

var land_num : int = 100 #土地数量
var self_land_type : String #土地类型


func _ready():
	for i in range(land_num):
		var one_dirt = preload("res://Objects/Farm/One Dirt.tscn").instantiate()
		one_dirt._set_dirt_type(land_type[name]) #设置土地图片，根据土地集群的名字设置土地类型
		add_child(one_dirt)
