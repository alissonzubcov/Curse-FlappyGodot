extends RigidBody2D

var pode_voar = true
onready var sprite = get_node("animate")
var current_scene

func _ready():
	set_process(true)
	add_to_group("flappy")
	set_sleeping(true)
	current_scene = get_tree().get_current_scene()

	pass

func _process(delta):
	#print(str(get_linear_velocity().y)) #printando 
	jump()
	rotacao_pulo(delta)
	pass
	
func jump():
	if Input.is_action_pressed("touch") and pode_voar and current_scene.is_playing() :
		#set_mode(2) #character
		set_sleeping(false)
		pode_voar = false
		set_linear_velocity(Vector2(0,-500))
		#set_linear_velocity(Vector2(0,0))
		#apply_impulse(Vector2(0,0), Vector2(0, -9000))
		get_node("samples").play("wing")
		pass

	if !Input.is_action_pressed("touch"):
		pode_voar = true
	pass


func rotacao_pulo(delta):
	#sprite referencia a animacao
	if not is_sleeping():
		var vel = get_linear_velocity().y
		if vel < 0:
			sprite.set_rotd(lerp(sprite.get_rotd(), 15.0, 20.0*delta))
		elif vel >300:
			sprite.set_rotd(lerp(sprite.get_rotd(), -90.0, 5.0*delta))