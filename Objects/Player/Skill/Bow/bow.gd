extends Node2D

@export var anima : Node2D
@export var anima_ : AnimatedSprite2D
@export var attack_timer : Timer

var rotation_speed : float = 0.5 #idle时自身旋转速度

var attack_goal : Array[Node2D] #攻击对象列表

var Player : CharacterBody2D #因为弓箭是依附在玩家身上的，所以 Player.position 才是真实位置

func _ready():
	Player = get_node("../..")

func _process(_delta):
	if attack_goal.size() == 0:
		anima_.play("idle")
		#没有目标时，自身围绕玩家旋转
		if anima.rotation_degrees + rotation_speed == 361:
			anima.rotation_degrees = 0
		else:
			anima.rotation_degrees += rotation_speed
		attack_timer.stop()
	else:
		#有目标时候，选着距离最近的目标进行瞄准
		_sort_goals() #进行距离排序，让最近的目标放在第一位，以便后续操作
		#弓箭指向
		anima.look_at(attack_goal[0].position)
		anima.rotation_degrees += 135 #角度校准
		#射击逻辑->开启计时器，计时器结束射击一次
		if attack_timer.is_stopped():
			_on_attack_timer_timeout() #一来就先调用一次->这个可能导致在边缘ob从而射的很快
			attack_timer.start()

#进入攻击范围，添加该对象到攻击对象数组中
func _on_attack_range_body_entered(body):
	attack_goal.append(body)

#离开攻击范围，将该对象从攻击数组中移除
func _on_attack_range_body_exited(body):
	attack_goal.erase(body)

#排序会使用到的比较函数
func _witch_to_player_nearest(a : Node2D,b : Node2D):
	return a.position.distance_to(Player.position) < b.position.distance_to(Player.position)

#对距离进行排序
func _sort_goals() -> void:
	attack_goal.sort_custom(_witch_to_player_nearest)

func _on_attack_timer_timeout():
	anima_.play("attack")
	await anima_.animation_finished #这里千万要记得动画不能设置成循环播放了->这里在帧调用里面使用会导致卡顿
	if attack_goal.size() != 0:
		var Bow_Bullet = preload("res://Objects/Player/Skill/Bow/Bow Bullet.tscn").instantiate()
		Bow_Bullet.goal = attack_goal[0].position
		Bow_Bullet.scale = Vector2(3,3)
		Bow_Bullet.position = Player.position
		Player.get_node("..").add_child(Bow_Bullet)
		anima_.play("idle")
