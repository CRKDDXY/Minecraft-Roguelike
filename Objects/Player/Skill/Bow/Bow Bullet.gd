extends CharacterBody2D

@export var queue_timer : Timer
var speed : float = 900
var goal : Vector2 #目标对象->延长，这里的距离不重要，只需要飞出屏幕即可，有计时器会清楚该箭的

func _ready():
	queue_timer.start()
	goal = get_point_behind(position, goal, 100000)

func _process(_delta):
	velocity = position.direction_to(goal) * speed
	look_at(goal)
	rotation_degrees += 135
	move_and_slide()

#自身消除计时器
func _on_queue_time_timeout():
	self.queue_free()

# 计算从B点沿着A->B方向延伸某个距离的点
func get_point_behind(a: Vector2, b: Vector2, distance: float) -> Vector2:
	# 计算从A到B的方向向量
	var direction = b - a
	# 标准化方向向量
	direction = direction.normalized()
	# 沿着这个方向向量延伸指定的距离
	var new_point = b + direction * distance
	return new_point

var can_give_player_hit : bool = true

func _on_hit_body_entered(body):
	if body.name == "Player":
		#每只箭只能攻击玩家一次
		if can_give_player_hit:
			can_give_player_hit = false
			body._get_hit(0)
	else:
		body._get_hit()
