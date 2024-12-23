extends Node2D

@export var Player : CharacterBody2D

@export var Stand : Area2D #炼药台

func _ready():
	#去除玩家技能显示
	for skill_index in range(Player.get_node("Skills").get_child_count()):
		Player.get_node("Skills").get_child(skill_index).queue_free()
	Player.move_speed = 40


var Can_use_stand : bool = false #设置个使用范围，靠近台子才能观察和使用

func _Player_in_Stand_Range(_body : Node2D):
	Can_use_stand = true
	
func _Player_Level_Stand_Range(_body : Node2D):
	Can_use_stand = false
