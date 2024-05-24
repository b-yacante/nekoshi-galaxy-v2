extends RigidBody3D

var speed = 1
var parentNode
var meshInstance
@export var asteroids_mesh = []

# Called when the node enters the scene tree for the first time.
func _ready():
	parentNode = get_node("MeshInstance")
	var rand = RandomNumberGenerator.new()
	var rand_mesh = rand.randi_range(0,5)
	var path_mesh = asteroids_mesh[rand_mesh]
	if not path_mesh == null:
		meshInstance = load(path_mesh).instantiate()
		parentNode.add_child(meshInstance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_central_force(Vector3(0,0,speed))

func _on_area_3d_area_entered(area):
	if area.name == "NekoshiArea":
		queue_free()
	if area.name == "DestructionWall":
		queue_free()
