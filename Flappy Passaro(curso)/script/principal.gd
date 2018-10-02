extends Node2D

var path

func anim():
	get_tree().change_scene(path) #chama cena do game
	
func fade_to(path):
	self.path = path
	get_node("anim").play("fade")