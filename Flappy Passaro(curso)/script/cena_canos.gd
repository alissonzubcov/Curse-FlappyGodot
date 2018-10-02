extends Node2D

onready var pipe_top = get_node("pipe_top")
onready var pipe_down = get_node("pipe_down")
onready var position = get_node("Position2D")
var current_scene
var vel = 150


func _ready():
	
	randomize()
	current_scene = get_tree().get_current_scene()
	setando_pos()
	set_process(true)
	pass

func setando_pos():
	var variacao = rand_range( -150, 130)
	#pipe_top.set_global_pos(pipe_top.get_global_pos() + Vector2(0,variacao))
	#pipe_down.set_global_pos(pipe_down.get_global_pos() + Vector2(0,variacao))
	position.set_global_pos(Vector2(get_pos().x, variacao))
	pipe_top.set_global_pos(pipe_top.get_global_pos() + Vector2(position.get_pos()))
	pipe_down.set_global_pos(pipe_down.get_global_pos() + Vector2(position.get_pos()))
	get_node("areaScore").set_pos(position.get_pos())
	pass
	
func _process(delta):
	if current_scene.is_playing():
		set_global_pos(get_global_pos() + Vector2(-1, 0) * delta * vel)
	
	if get_global_pos().x < -50: #liberando
		print("cano destruido")
		queue_free()
	pass

func _on_area2D_body_enter( body ):
	if body.is_in_group("flappy"):
		current_scene.kill()
		

func _on_area2D_body_enter_shape( body_id, body, body_shape, area_shape ):
	if body.is_in_group("flappy"):
		current_scene.kill()


func _on_areaScore_body_enter( body ):
	script_principal.emit_signal("score")
	pass # replace with function body
