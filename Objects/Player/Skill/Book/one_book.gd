extends Area2D

func _on_body_entered(body):
	body._get_hit()
