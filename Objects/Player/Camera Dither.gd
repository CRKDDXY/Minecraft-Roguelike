
#相机抖动 -> 抖动功能需要移植到单个对象

extends Camera2D

@export var decay : float = 0.8 #衰减变量
@export var max_offset : Vector2 = Vector2(20,20) #相机最大偏移值
@export var max_roll :float = 0.1 #最大滚动
@export var follow_node :Node2D #跟随节点 用于被分配给跟随对象

var trauma : float = 0.0 #相机抖动强度
var trauma_power :int = 1 #抖动效果强度

func shake():
	var amount = pow(trauma,trauma_power)
	rotation = max_roll * amount * randf_range(-1,1)
	offset.x = max_offset.x * amount * randf_range(-1,1)
	offset.y = max_offset.y * amount * randf_range(-1,1)

func _ready():
	enabled = true #相机启动
	randomize() #随机化种子

func _process(delta):
	#相机位置跟随父节点
	#if follow_node:
	#	global_position = follow_node.global_position		
	if trauma:
		trauma = max(trauma - decay * delta , 0)
		shake()

func add_trauma(amount : float) -> void:
	trauma = 0 #抖动重置->防止类似于连点器的功能，导致traum过大，抖动幅度太大
	trauma = min(trauma + amount , 1.0) #幅度限制->在递增中会使用到，不然就固定为amount
