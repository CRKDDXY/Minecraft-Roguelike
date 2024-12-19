extends CharacterBody2D

var speed : float = 100

func _get_hit():
	self.queue_free()

@export var anima_father : Node2D
@export var anima : AnimatedSprite2D
@export var attack_timer : Timer
var goal : CharacterBody2D #这里其实就是玩家对象
var player : CharacterBody2D

func _ready():
	player = get_node("../../Player")

func _on_attack_range_body_entered(body):
	goal = body

func _on_attack_range_body_exited(_body):
	goal = null

func _process(_delta):
	if goal == null:
		anima.play("idle")
		attack_timer.stop()
	else:
		if goal != null:
			anima_father.look_at(goal.position)
			anima_father.rotation_degrees += 135 #角度校准
		if attack_timer.is_stopped():
			_on_attack_timer_timeout() #射击逻辑
			attack_timer.start()
	
	#移动逻辑
	if player != null and goal == null:
		velocity = position.direction_to(player.position) * speed
		move_and_slide()

var bullet_num : int = 0

func _on_attack_timer_timeout():
	bullet_num += 1
	anima.play("attack")
	await anima.animation_finished #这里千万要记得动画不能设置成循环播放了->这里在帧调用里面使用会导致卡顿
	bullet_num -= 1
	if goal != null and bullet_num == 0:
		var Bow_Bullet = preload("res://Objects/Player/Skill/Bow/Bow Bullet.tscn").instantiate()
		Bow_Bullet.goal = goal.position
		Bow_Bullet.scale *= 3
		Bow_Bullet.position = position
		Bow_Bullet.get_node("hit").collision_layer = 6 #怪物子弹
		Bow_Bullet.get_node("hit").collision_mask = 1 #攻击对象玩家
		Bow_Bullet.modulate = Color8(255,127,127)
		Bow_Bullet.speed = 300 #怪物子弹的移动速度
		get_node("../../Enemy Bullets").add_child(Bow_Bullet)
		anima.play("idle")
