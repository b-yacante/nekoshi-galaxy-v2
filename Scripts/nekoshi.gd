extends CharacterBody3D

#MOVEMENT
@export var speed = 2
const LANE_DISTANCE = 0.65
var _lanePos =  Vector2i(0,0) # -1: left/up | 0: middle | 1: right/down
var targetVelocity
#SWIPE
var _swipeLenght = 100
var _swipeStart = Vector2.ZERO
var isSwiping = false

func _physics_process(delta):
	var targetPosition = Vector3(_lanePos.x * LANE_DISTANCE, _lanePos.y, global_position.z)
	var new_position = position.lerp(targetPosition, speed * delta)

func _input(event):
	if  event is InputEventMouseButton:
		if event.is_pressed():
			_swipeStart = event.position
		else:
			print("algo")
		#ejecutar calculate swipe
		#emitir la senial
