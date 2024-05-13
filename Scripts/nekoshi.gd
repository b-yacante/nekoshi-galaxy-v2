extends CharacterBody3D

var _lanePos =  Vector2i(0,0) # -1: left/up | 0: middle | 1: right/down
const LANE_DISTANCE = 0.65
@export var speed = 2


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var targetPosition = new()
