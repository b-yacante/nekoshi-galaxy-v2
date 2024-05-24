extends Node3D
var obstacleSpeed: float = 1
const LANE_DISTANCE = 0.65
#timer variables
var timer_ref
var base_time_timer = 1.5
var current_time_timer = base_time_timer
var max_time_of_timer = 0.6
#obstacle variables
var base_amount_obstacles: int = 1
var current_amount:int = 1
var max_amount_obstacles: int = 6

var max_time = GameController.time_to_max_speed
var elapse_time: float = 0

func _ready():
	timer_ref = get_node("Timer")

func _process(delta):
	elapse_time += delta
	var progression_ratio = elapse_time / max_time
	progression_ratio = clamp(progression_ratio,0,1)
	
	#progression of the timer
	current_time_timer = base_time_timer + (max_time_of_timer - base_time_timer) * progression_ratio
	timer_ref.wait_time = current_time_timer
	
	#progression of the obstacles
	var current = base_amount_obstacles + (max_amount_obstacles - base_amount_obstacles) * progression_ratio
	current_amount = roundi(current)

func _instantiate_obstacles(amount: int):
	var auxArr: Array[Vector2i] = []
	for instancia in amount:
		var sceneToInstance = preload("res://Scenes/obstacle.tscn").instantiate()
		add_child(sceneToInstance)
		var rand_number = RandomNumberGenerator.new()
		var rand_lane_x = 0
		var rand_lane_y = 0
		while true:
			rand_lane_x = rand_number.randi_range(-1,1)
			rand_lane_y = rand_number.randi_range(-1,1)
			var random_val = Vector2i(rand_lane_x, rand_lane_y)
			for el in auxArr:
				if not el == random_val:
					auxArr.push_back(el)
			break
		#le asignamos la posicion a la escena
		sceneToInstance.position = Vector3(rand_lane_x * LANE_DISTANCE,rand_lane_y * LANE_DISTANCE,sceneToInstance.position.z)


func _on_timer_timeout():
	var rand_number = RandomNumberGenerator.new()
	var amount = rand_number.randi_range(1,current_amount)
	_instantiate_obstacles(amount)
