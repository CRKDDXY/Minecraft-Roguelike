extends CharacterBody2D

var speed : float = 100

func _get_hit():
	self.queue_free()

func _process(_delta):
	if get_node("../..").Player != null:
		velocity = position.direction_to(get_node("../..").Player.position) * speed
		move_and_slide()
