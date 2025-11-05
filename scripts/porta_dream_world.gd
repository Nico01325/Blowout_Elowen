extends Area2D

@export var next_level: String = "res://cenas/topdown_world.tscn"

@onready var sprite: AnimatedSprite2D = $Sprite2D  # Certifique-se de que o nome está correto!

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.tempo_acabado >= 1:
			if sprite:
				sprite.play("porta_abrindo")
				await get_tree().create_timer(2.0).timeout

			# 👇 Diminui o contador de "tempo_acabado" ao usar a porta
			Global.tempo_acabado -= 1

			Global.destination_level = get_parent().name
			get_tree().change_scene_to_file(next_level)
			
		else:
			if sprite:
				sprite.play("porta_normal")
			print("Você precisa de 2 itens para usar a porta!")
