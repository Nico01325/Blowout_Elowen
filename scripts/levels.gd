extends Node2D

@export var player : Node2D  # arraste o Player da cena para esse campo no editor

func _ready() -> void:
	if Global.destination_level != "":
		var point = get_node(Global.destination_level)
		if point: 
			player.global_position = point.global_position

func _on_spawner_de_inimigo_timeout() -> void:
	var cena_inimigo = preload("res://cenas/Inimigo.tscn") 
	var novo_inimigo = cena_inimigo.instantiate()
	
	# Passa o jogador atual para o inimigo
	novo_inimigo.player = player

	# Gera posição aleatória em volta do jogador
	var random = RandomNumberGenerator.new()
	var posicaoJogador = player.global_position
	var offset = Vector2(random.randi_range(100, 200), random.randi_range(100, 200))
	
	novo_inimigo.position = posicaoJogador + offset
	add_child(novo_inimigo)
