extends RigidBody3D
var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_central_force(Vector3(0,0,speed))

func _on_area_3d_area_entered(area):
	if area.name == "NekoshiArea":
		queue_free()
	if area.name == "DestructionWall":
		queue_free()
