extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Global.itens_coletados += 1
		print("Item coletado")
		queue_free()
