extends Node2D
# ___________VARIÁVEIS_________________
var pre_cano = preload("res://scenes/cena_canos.tscn")

onready var background = get_node("background")
onready var flappy = get_node("flappy")
onready var tempo_reload = get_node("reload") 

var intervalo = 1
var timer = 0

var kill = false
var playing = false
var reloading = false
# ___________VARIÁVEIS_________________


func _ready():
	set_process(false)
	set_process_input(true)
	script_principal.connect("score", self, "score_pontos")
	pass


func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH :
		if event.is_pressed():
			if !kill and playing != true:
				start_beggin()
			elif reloading:
				restart()
	pass


func start_beggin(): #iniciando o jogo

	playing = true
	get_node("HUD/push").hide()
	background.play("flash")
	flappy.show()
	get_node("HUD/score").show()
	#logo.hide()
	flappy.set_sleeping(false)
	flappy.jump()
	set_process(true)
	pass


func _process(delta):
	if playing:
		if timer > 0:
			timer -= delta
		else:
			timer = intervalo
			novos_canos()
	pass


func novos_canos():
	var novo_cano = pre_cano.instance()
	novo_cano.set_global_pos(Vector2(320,0))
	add_child(novo_cano)


func kill():
	if not kill:
		kill = true
		playing = false
		set_process(false)
		background.stop()
		flappy.sprite.stop()
		tempo_reload.start()
		background.play("flash")
		get_node("samples").play("hit")
	pass


func _on_kill_flappy_body_enter( body ):
	flappy.set_sleeping(true)
	kill()
	get_node("HUD/game_over").show()
	pass


func is_playing():
	return playing


func restart():
	script_principal.pontos = 0
	#get_tree().reload_current_scene()
	get_tree().change_scene("res://scenes/menu.tscn")
	pass


func _on_reload_timeout():
	#
	reloading = true
	get_node("HUD/restart").show()
	pass 
	
func score_pontos():
	get_node("samples").play("point")
	script_principal.pontos = script_principal.pontos +1
	get_node("HUD/score").set_text(str(script_principal.pontos))
	if script_principal.pontos > script_principal.mp:
		script_principal.mp = script_principal.pontos
		script_principal.salva_dados()
