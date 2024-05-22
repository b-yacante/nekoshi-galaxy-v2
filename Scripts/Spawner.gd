extends Node3D
var obstacleSpeed: float = 1
const LANE_DISTANCE = 0.65

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
	var amount = rand_number.randi_range(1,2)
	_instantiate_obstacles(amount)


func _on_space_space_velocity(vel):
	var obstacle = preload("res://Scenes/obstacle.tscn").instantiate()
	var multiplicador = vel / 100
	obstacle.speed = obstacleSpeed * multiplicador
