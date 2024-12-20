extends Node2D

@export var gird : GridContainer #背包格子队列

func _ready():
	for i in range(90):
		gird.add_child(preload("res://Objects/Player/Inventory/slot.tscn").instantiate())
	gird.get_child(0)._set_Item("wooden_hoe")
	gird.get_child(1)._set_Item("water_bucket")
	gird.get_child(2)._set_Item("wheat_seed")
	gird.get_child(3)._set_Item("cocoa_beans")
	gird.get_child(4)._set_Item("nether_wart")
