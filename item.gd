extends Area2D
signal item_coletado

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("item_coletado")
		queue_free()
