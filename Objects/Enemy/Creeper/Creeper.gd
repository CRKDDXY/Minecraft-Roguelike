extends CharacterBody2D

#什么时候开始爆炸呢？玩家进入爆炸范围内，并且呆到了指定时间

var speed : float = 80
var player : CharacterBody2D

@export var ang_range : Node2D
@export var bang_timer : Timer
@export var creeper_texture : Sprite2D

func _ready():
	player = get_node("../../Player")

var can_kill : bool = true

#受击
func _get_hit():
	if can_kill:
		self.queue_free()

func _process(_delta):
	if player != null and can_move:
		velocity = position.direction_to(player.position) * speed
		move_and_slide()
	if ang_range.begin_ready_bang:
		if bang_timer.is_stopped():
			bang_timer.start()
	else:
		bang_timer.stop()
		

var can_move : bool = true
#停止移动的范围
func _on_stop_move_body_entered(_body):
	can_move = false
func _on_stop_move_body_exited(_body):
	can_move = true

#开始爆炸
func _on_bang_timer_timeout():
	var tween = creeper_texture.create_tween()
	var bang_modulate = creeper_texture.modulate
	bang_modulate = Color8(255,70,70)
	tween.tween_property(creeper_texture,"modulate",bang_modulate,0.8)
	await tween.finished
	tween.kill()
	if ang_range.begin_ready_bang:
		ang_range._state_to_bang()
		can_move = false #开始爆炸了，停止移动
		#到这里就已经算是开始爆炸了，不能被阻止，所以修改苦力怕的是否能被击杀的逻辑，防止爆炸中途被子弹击中消除
		can_kill = false
		creeper_texture.visible = false
	else:
		creeper_texture.modulate = Color8(255,255,255)
