extends TextureProgressBar

@export var level_text : Label

var level_num : int = 0 #等级
var level_value : int = 0 #现有经验

func _ready():
	max_value = 2 * 0 + 7 #设置升级所需经验值

func _add_level_value():
	
	level_value += 1
	
	if level_num >= 0 and level_num <= 15: # 0-15
		if level_value == 2 * level_num + 7:
			level_value = 0
			level_num += 1
			max_value = 2 * level_num + 7

	if level_num >= 16 and level_num <= 30: #16-30
		if level_value == 5 * level_num - 38:
			level_value = 0
			level_num += 1
			max_value = 5 * level_num - 38

	if level_num >= 31 : # 31 - 无穷大
		if level_value == 9 * level_num - 158:
			level_value = 0
			level_num += 1
			max_value = 9 * level_num - 158

	_bar_update() #经验条更新

func _bar_update():
	level_text.text = str(level_num) #经验等级设置
	value = level_value #经验条设置
