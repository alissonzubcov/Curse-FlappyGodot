extends Node2D


func _ready():
	#get_node("pt").set_text(str(script_principal.maior_ponto)) #Recuperando a maior_pontuacao
	script_principal.carregar_dados()

	pass

func _on_jogar_pressed():
	#get_tree().change_scene("res://scenes/game.tscn") #chama cena do game
	principal.fade_to("res://scenes/game.tscn")
