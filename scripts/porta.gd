extends Area2D

@export var next_level: String = "res://cenas/._topdown_world2.tscn"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.itens_coletados >= 2:
			
			# Toca animação de abrir a porta
			sprite.play("porta_abrindo")
			
			# Espera terminar (2 segundos ou o tempo da animação)
			await get_tree().create_timer(2.0).timeout
			
			Global.destination_level = get_parent().name
			get_tree().change_scene_to_file(next_level)
		else:
			print("Você precisa de 2 itens para usar a porta!")
