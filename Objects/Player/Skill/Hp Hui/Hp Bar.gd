extends GridContainer

var hp_state = {
	"hold" = "res://Objects/Player/Skill/Hp Hui/hold.png",
	"lose" = "res://Objects/Player/Skill/Hp Hui/lose.png"
}

var total_hp_num : int = 0 #目前拥有的总血量
var hold_hp_num : int #目前剩余的血量

#血量分的是次数
func _max_value_update(num : int):
	total_hp_num += num #总血量修改
	if num > 0: #加血
		for i in range(num):
			var append_hp : TextureRect = TextureRect.new()
			append_hp.texture = load(hp_state["hold"])
			self.add_child(append_hp)
	else: #减血
		for i in range(abs(num)):
			self.get_child(i).queue_free()
	_hp_bar_update()

func _hp_bar_update():
	for i in range(self.get_child_count()):
		if i < hold_hp_num:
			self.get_child(i).texture = load(hp_state["hold"])
		else:
			self.get_child(i).texture = load(hp_state["lose"])

func _player_get_hit(num : int):
	if hold_hp_num > num:
		hold_hp_num -= num
		_hp_bar_update() #更新血条
	else:
		pass
		#死亡逻辑

func _ready():
	hold_hp_num = 20
	_max_value_update(20) #初始设置20滴血
	#_max_value_update(-5) #测试顺序使用过
