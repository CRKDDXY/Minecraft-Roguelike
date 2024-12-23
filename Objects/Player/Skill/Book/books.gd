extends Node2D

# 设定圆的半径
var radius = 35
var book_num : int = 3 #实际上就是get_child_count()

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

func _set_book_num(num : int):
	for i in range(abs(num)):
		if num > 0:
			add_child(preload("res://Objects/Player/Skill/Book/one_book.tscn").instantiate())
		else:
			get_child(-1).queue_free()
	_set_book_position() #设置位置

func _ready():
	_set_book_num(3)

func _process(_delta):
	if self.rotation_degrees + 0.5 >= 361:
		self.rotation_degrees = 0
	else:
		self.rotation_degrees += 0.5
