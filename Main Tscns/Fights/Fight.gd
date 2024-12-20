extends Node2D

@export var Enemy : Node2D

@export var Player : CharacterBody2D

func _ready():
	#get_window().mode = Window.MODE_FULLSCREEN #全屏模式
	pass

var enemy_num : int = 40 #怪物数量上限设置

func _process(_delta):
	if Enemy.get_child_count() < enemy_num:
		for i in range(enemy_num - Enemy.get_child_count()):
			var enemy : CharacterBody2D = null
			match(randi_range(0,2)):
				0:enemy = preload("res://Objects/Enemy/Zombie/zombie.tscn").instantiate()
				1:enemy = preload("res://Objects/Enemy/Skeleton/Skeleton.tscn").instantiate()
				2:enemy = preload("res://Objects/Enemy/Creeper/Creeper.tscn").instantiate()
			# 生成随机的角度
			var angle = randf_range(0, 2 * PI)
			# 生成随机的半径，范围是 400 到 600
			var radius = randf_range(400, 600)
			# 计算 x 和 y 坐标
			var x = radius * cos(angle)
			var y = radius * sin(angle)
			# 设置敌人的位置
			enemy.position = Player.position + Vector2(x, y)
			enemy.scale = Vector2(6,6)
			#连接一个死亡方法，用于死亡后在原地生成一个经验瓶
			enemy.tree_exited.connect(_Enemy_Killed.bind(enemy))
			Enemy.add_child(enemy)

@export var Expers : Node2D #经验瓶所在的根节点

func _Enemy_Killed(enemy : CharacterBody2D):
	var ExOrb : Area2D = preload("res://Objects/Experience Orb/Experience.tscn").instantiate()
	ExOrb.scale *= 2.7
	ExOrb.position = enemy.position
	Expers.add_child(ExOrb)
