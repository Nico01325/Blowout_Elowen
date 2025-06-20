extends Area2D

@onready var textura: Sprite2D = $textura

const lines: Array[String] = [
	"oi caba",
	"asdsadsadsa",
	"asdadsa",
	"asdasdsadsads"
]

var player_inside := false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  # ou verifique por grupo, tipo body.is_in_group("jogador")
		player_inside = true
		if not DialogosScript.is_message_active:
			textura.show()

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false
		textura.hide()
		if DialogosScript.is_message_active:
			DialogosScript.force_close()

func _unhandled_input(event):
	if player_inside:
		if event.is_action_pressed("interagir"):
			if DialogosScript.is_message_active:
				DialogosScript.force_close()
			else:
				textura.hide()
				DialogosScript.start_message(global_position, lines)
