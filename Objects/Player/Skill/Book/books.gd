extends Node2D

# 设定圆的半径
var radius = 35

func _set_book_position():
	var num_book = get_child_count()
	for i in range(num_book):
		# 计算当前对象的角度（弧度）
		var angle = i * (2 * PI / num_book)
		# 计算对象的坐标
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		# 创建对象（比如使用一个Sprite或Node2D作为占位符）
		get_child(i).position = Vector2(x, y)
		# 如果使用的是Sprite2D，设置图像

func _ready():
	_set_book_position()

func _process(_delta):
	if self.rotation_degrees + 0.5 >= 361:
		self.rotation_degrees = 0
	else:
		self.rotation_degrees += 0.5
