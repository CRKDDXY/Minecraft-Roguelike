extends Node2D

@export var bang_range : Area2D
@export var particles : Node2D

@export var anima_1 : AnimatedSprite2D

var player : CharacterBody2D

var begin_ready_bang : bool = false

var can_give_player_hit : bool = true #设置只能产生一次伤害

func _process(_delta):
	if anima_1.frame == 3 and anima_1.animation == "bang": #第10帧爆炸帧时调用，防止出现延迟的视觉效果
		if player != null and can_give_player_hit:
			player._get_hit(1)
			can_give_player_hit = false

#进入爆炸状态
func _state_to_bang():
	for i in range(particles.get_child_count()):
		particles.get_child(i).play("bang")

func _on_bang_range_body_entered(body):
	player = body
	begin_ready_bang = true

func _on_bang_range_body_exited(_body):
	player = null
	begin_ready_bang = false

func _on__animation_finished():
	self.get_node("..").queue_free() #爆炸动画结束，父节点消除->这里直接指向整个Creeper的根节点
