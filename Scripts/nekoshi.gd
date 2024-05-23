extends CharacterBody3D
signal LanePosition(lanePos: Vector2i)
signal UpdateLife(life: int)

var life: int = 3
#MOVEMENT
@export var speed = 2
const LANE_DISTANCE = 0.65
var _lanePos =  Vector2i(0,0) # -1: left/up | 0: middle | 1: right/down
var targetVelocity
#SWIPE
var _swipeLength = 100
var _swipeStart = Vector2.ZERO
var isSwiping = false

func _physics_process(delta):
	var targetPosition = Vector3(_lanePos.x * LANE_DISTANCE, _lanePos.y, global_position.z)
	var new_position = position.lerp(targetPosition, speed * delta)
	global_position = new_position

func _input(event):
	if  event is InputEventMouseButton:
		if event.is_pressed():
			_swipeStart = event.position
		else:
			CalculateSwipe(event.position)
			LanePosition.emit(_lanePos)

func CalculateSwipe(_swipeEnd: Vector2):
	if(_swipeStart == Vector2.ZERO): return
	var swipe = _swipeEnd - _swipeStart
	if(abs(swipe.x) > _swipeLength):
		if(swipe.x > 0): MoveRight()
		else: MoveLeft()
	elif (abs(swipe.y)> _swipeLength):
		if (swipe.y < 0): MoveUp()
		else: MoveDown()

func TakeDamage(damage: int):
	life = life - damage
	UpdateLife.emit(life)

func MoveUp():
	_lanePos.y += 1
	if (_lanePos.y == 2): _lanePos.y = 1
func MoveDown():
	_lanePos.y -= 1
	if(_lanePos.y == -2): _lanePos.y = -1
func MoveRight():
	_lanePos.x += 1
	if (_lanePos.x == 2): _lanePos.x = 1
func MoveLeft():
	_lanePos.x -= 1
	if (_lanePos.x == -2): _lanePos.x = -1


func _on_nekoshi_area_area_entered(area):
	if area.name == "ObstacleArea":
		TakeDamage(1)
