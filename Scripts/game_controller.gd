extends Node

signal SpaceVelocity(vel: int)

var multVelocity: float = 1
var progressTime: float = 5
var gameTime: float = 5

func _process(delta):
	var timeElapse = Time.get_ticks_msec()
	gameTime = timeElapse / 1000.0
	if(gameTime >= progressTime):
		multVelocity += 1
		SpaceVelocity.emit(multVelocity)
		progressTime += gameTime
