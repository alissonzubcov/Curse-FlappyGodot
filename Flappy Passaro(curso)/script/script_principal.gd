extends Node

var processos = true

signal score

var pontos = 0
#var maior_ponto = 0
var mp = 0

func salva_dados():
	var dados = {"maior_pontuacao": mp}
	var f = File.new()
	var erro = f.open("user://save.data", File.WRITE)
	if not erro:
		f.store_var(dados)
	else:
		print("erro ao salvar dados")
	pass
func carregar_dados():
	var f = File.new()
	var erro = f.open("user://save.data", File.READ)
	if not erro:
		var dados_salvos = f.get_var()
		mp = dados_salvos["maior_pontuacao"]
	else:
		print("erro ao carregar dados")
	get_tree().get_root().get_node("menu/pt").set_text(str(mp))
