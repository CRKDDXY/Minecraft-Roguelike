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
	if can_give_hit and can_give_player_hit_goal != null:
		print("玩家扣血")
		can_give_player_hit_goal._get_hit(0)
		can_give_hit = false

var can_give_player_hit_goal : CharacterBody2D
var can_give_hit : bool = true

func _on_attack_range_body_entered(body):
	can_give_player_hit_goal = body
func _on_attack_range_body_exited(_body):
	can_give_player_hit_goal = null

func _on_attack_timer_timeout():
	can_give_hit = true
