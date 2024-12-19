extends Area2D

@export var Sp2d : Sprite2D

var ro_dir : bool = false #晃动方向，false是左边，true是右边
var ro_max_value : float = 15 #晃动幅度

func _process(_delta):
	#晃动的逻辑
	if ro_dir:
		Sp2d.rotation_degrees -= 0.3
		if Sp2d.rotation_degrees <= -ro_max_value:
			ro_dir = false
	else:
		Sp2d.rotation_degrees += 0.3
		if Sp2d.rotation_degrees >= ro_max_value:
			ro_dir = true

#一个瓶子只能产生一次经验增加
func _on_body_entered(body):
	var tween = create_tween() #创建移动用的孪生
	tween.tween_property(self,"position",body.position,0.2)
	await tween.finished
	tween.kill()
	#给玩家加经验
	body.ExBar._add_level_value()
	self.queue_free() #自生清除
