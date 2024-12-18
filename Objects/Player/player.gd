extends CharacterBody2D

var move_speed : float = 150 #玩家初始移动速度

#武器库
@export var skills : Node2D #技能组

func _ready():
	var skill_bow = preload("res://Objects/Player/Skill/Bow/bow.tscn").instantiate()
	skill_bow.scale *= 0.5
	var skill_books = preload("res://Objects/Player/Skill/Book/books.tscn").instantiate()
	skill_books.scale *= 0.5
	
	#skills.add_child(skill_bow)
	#skills.add_child(skill_books)

func _process(_delta):
	#移动逻辑
	var direction_y = Input.get_axis("move_up", "move_down")
	if direction_y == 0:velocity.y = 0
	else:velocity.y = move_speed * direction_y
	var direction_x = Input.get_axis("move_left", "move_right")
	if direction_x == 0:velocity.x = 0
	else:velocity.x = move_speed * direction_x
	move_and_slide()

func _get_hit():
	print("受击")
