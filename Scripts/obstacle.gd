extends RigidBody3D

@export var asteroids_mesh = []
@export var yellow_mark_distance := Vector3(0,0,12)
@export var blue_mark_distance := Vector3(0,0,8)
@export var green_mark_distance := Vector3(0,0,4)
var yellow_material = preload("res://Models/yellow_asteroid_mark.tres")
var blue_material = preload("res://Models/blue_asteroid_mark.tres")
var green_material = preload("res://Models/green_asteroid_mark.tres")

var parentNode
var meshInstance
var ray_cast_3d_mark
var mark_asteroid 
var asteroid_mark


func _ready():
	asteroid_mark = get_node('Asteroid Mark')
	ray_cast_3d_mark = get_node("RayCast3D_Mark")
	parentNode = get_node("MeshInstance")
	
	
	asteroid_mark.visible = false;
	#asteroid_mark.target_position = yellow_mark_distance
	mark_asteroid = asteroid_mark.get_child(0)
	for x in 8:
		mark_asteroid.set_surface_override_material(x, yellow_material)
	
	ray_cast_3d_mark.set_collision_mask_value(2, true)
	var rand = RandomNumberGenerator.new()
	var rand_mesh = rand.randi_range(0,5)
	var path_mesh = asteroids_mesh[rand_mesh]
	if not path_mesh == null:
		meshInstance = load(path_mesh).instantiate()
		parentNode.add_child(meshInstance)

func _physics_process(delta):
	apply_central_force(Vector3(0,0,GameController.speed_emitted))

func _process(delta):
	detectProximityWall()

func _on_area_3d_area_entered(area):
	if area.name == "NekoshiArea":
		queue_free()
	if area.name == "DestructionWall":
		queue_free()

func change_mark_color(color: Vector3):
	asteroid_mark.target_position = color

func detectProximityWall():
	if ray_cast_3d_mark.is_colliding():
		var body = ray_cast_3d_mark.get_collider()
		if body != null:
			if body.name == "DestructionWall":
				asteroid_mark.visible = true
				if body.position <= blue_mark_distance:
					change_mark_color(blue_mark_distance)
				if body.position <= green_mark_distance:
					change_mark_color(green_mark_distance)
		
