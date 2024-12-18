extends CharacterBody2D

var speed : float = 100
var player : CharacterBody2D

func _ready():
	player = get_node("../../Player")

func _get_hit():
	self.queue_free()

func _process(_delta):
	if player != null:
		velocity = position.direction_to(player.position) * speed
		move_and_slide()
