extends Control
var is_dead = false
var score = 0
var is_paused = false
var score_per_time = 2
var time_elapse = 0

var score_label 
var score_label_lose
var score_container
var pause_panel
var lose_panel

func _ready():
	score_container = get_node("ScoreContainer")
	score_label = get_node("ScoreContainer/ScoreLabel")
	pause_panel = get_node("PausePanel")
	score_label_lose = get_node("LosePanel/LoseWindow/ScoreLabelLose")
	lose_panel = get_node("LosePanel")
	
	pause_panel.visible = false
	lose_panel.visible = false
	
	
func _process(delta):
	if not is_paused:
		time_elapse += delta
		_update_score(time_elapse)

func _update_score(time: float):
	if not is_dead:
		score_container.visible = true
		#desactivar lose panel
		score = time / score_per_time
		score_label.text =  str(floor(score)) 


func _on_nekoshi_update_life(life):
	if life <= 0:
		is_dead = true
		score_container.visible = false
		score_label_lose.text = str(floor(score))
		lose_panel.visible = true
		get_tree().paused = true


func _on_pause_button_pressed():
	is_paused = true
	get_tree().paused = true
	pause_panel.visible = true
	


func _on_exit_button_pressed():
	is_paused = false
	pause_panel.visible = false
	get_tree().paused = false


func _on_replay_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
