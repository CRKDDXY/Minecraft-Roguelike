extends Node2D

@export var Enemy : Node2D

@export var Player : CharacterBody2D

func _ready():
	#get_window().mode = Window.MODE_FULLSCREEN #全屏模式
	pass

func _process(_delta):
	if Enemy.get_child_count() < 10:
		for i in range(10 - Enemy.get_child_count()):
			var enemy = null
			match(randi_range(0,1)):
				0:
					enemy = preload("res://Objects/Enemy/Zombie/zombie.tscn").instantiate()
				1:
					enemy = preload("res://Objects/Enemy/Skeleton/Skeleton.tscn").instantiate()
			# 生成随机的角度
			var angle = randf_range(0, 2 * PI)
			# 生成随机的半径，范围是 400 到 600
			var radius = randf_range(600, 800)
			# 计算 x 和 y 坐标
			var x = radius * cos(angle)
			var y = radius * sin(angle)
			# 设置敌人的位置
			enemy.position = Player.position + Vector2(x, y)
			enemy.scale = Vector2(6,6)
			Enemy.add_child(enemy)
	pass
