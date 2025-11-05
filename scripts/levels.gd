extends Node2D

@onready var player = $"."


func _ready() -> void:
	if Global.destination_level != "":
		var point = get_node(Global.destination_level)
		if point: 
			Player.global_position = point.global_position
			


func _on_spawner_de_inimigo_timeout() -> void:
	var cena_inimigo = preload("res://cenas/Inimigo.tscn") 
	var novo_inimigo = cena_inimigo.instantiate()
	novo_inimigo.Player = $Player
	var random = RandomNumberGenerator.new()
	var posicaoJogador = $Player.global_position
	novo_inimigo.position = Vector2(posicaoJogador.x + random.randi_range(100,200), posicaoJogador.y + random.randi_range(100,200) )
	add_child(novo_inimigo)
	pass # Replace with function body.
