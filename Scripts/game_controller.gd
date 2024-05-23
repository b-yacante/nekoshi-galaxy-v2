extends Node

signal SpaceVelocity(vel: int)
@export var progressTime: float = 5

var multVelocity: float = 1
var timeElapse = 0

func _ready():
	SpaceVelocity.emit(multVelocity)

func _process(delta):
	timeElapse += delta
	if(timeElapse >= progressTime):
		multVelocity += 1
		SpaceVelocity.emit(multVelocity)
		progressTime += timeElapse
