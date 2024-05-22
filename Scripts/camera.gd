extends Camera3D

@export var smothCamera: float = 2.0
@export var degreeRotation: float = 5.0
@export var movePosition: float = 0.2

var elapse := 6.0
var degRot := Vector2.ZERO
var pos := Vector2.ZERO

func _physics_process(delta):
	#Aplicamos rotacion a la camara segun la posicion del personaje
	var newRotation = rotation.lerp(Vector3(deg_to_rad(degRot.x), deg_to_rad(degRot.y), 0) , delta * elapse)
	rotation = newRotation


func _on_nekoshi_lane_position(lanePos):
	if(lanePos.y < 0):
		degRot.x = degreeRotation + 10
	elif (lanePos.y > 0):
		degRot.x = (degreeRotation +10) * -1
	else:
		degRot.x = 0
	if (lanePos.x> 0):
		degRot.y = degreeRotation
	elif (lanePos.x < 0):
		degRot.y = degreeRotation * -1
	else:
		degRot.y = 0
