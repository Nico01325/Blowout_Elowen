extends Area2D

@export var next_level: String = "res://cenas/topdown_world2.tscn"

@onready var sprite: AnimatedSprite2D = $Sprite2D # Ajuste se necessário

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.itens_coletados >= 2:

			if sprite:
				sprite.play("porta_abrindo")
				await get_tree().create_timer(2.0).timeout
			
			# Marca o nível atual como destino
			Global.destination_level = get_parent().name

			# Remove 2 itens coletados ao passar pela porta
			Global.itens_coletados -= 2  

			# Muda de cena
			get_tree().change_scene_to_file(next_level)

		else:
			if sprite:
				sprite.play("porta_normal")
			print("Você precisa de 2 itens para usar a porta!")
