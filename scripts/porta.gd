extends Area2D

@export var next_level: String = "res://cenas/._topdown_world2.tscn"  # Exemplo: res://fases/fase2.tscn

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.itens_coletados >= 2:
			Global.destination_level = get_parent().name
			get_tree().change_scene_to_file(next_level)
		else:
			print("Você precisa de 2 itens para usar a porta!")
