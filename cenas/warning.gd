# npc_dialogo.gd (attached to Area2D)
extends Area2D

@onready var textura: Sprite2D = $textura
@export var lines: Array[String]

var player_inside := false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		player_inside = true
		_update_texture_visibility()

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false
		_update_texture_visibility()

func _unhandled_input(event):
	# Só inicia o diálogo se o jogador estiver dentro e NÃO houver diálogo ativo
	if player_inside and event.is_action_pressed("interagir"):
		if not DialogosScript.is_message_active:
			DialogosScript.start_message(global_position + Vector2(0, -30), lines)
			_update_texture_visibility()

func _update_texture_visibility():
	textura.visible = player_inside and not DialogosScript.is_message_active
