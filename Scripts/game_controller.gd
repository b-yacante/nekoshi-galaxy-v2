extends Node
signal SpaceVelocity(vel: float)

@export var base_speed = 0
@export var speed_increment = 0.5
@export var max_speed = 20
@export var time_to_max_speed = 120
var current_speed = base_speed
var speed_emitted = 0
var elapse_time = 0

#func _ready():
	#SpaceVelocity.emit(current_speed)

func _process(delta):
	elapse_time += delta
	var progression_ratio = elapse_time / time_to_max_speed
	progression_ratio = clamp(progression_ratio,0,1)
	
	current_speed = base_speed + (max_speed - base_speed) * progression_ratio
	current_speed = min(current_speed, max_speed)
	speed_emitted = current_speed
	
	

