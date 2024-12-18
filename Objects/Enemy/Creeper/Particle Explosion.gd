extends Node2D

@export var bang_range : Area2D
@export var particles : Node2D
var player : CharacterBody2D

var begin_ready_bang : bool = false

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
	if player != null:
		player._get_hit()
	self.get_node("..").queue_free()
