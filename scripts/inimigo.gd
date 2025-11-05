extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var detection_area: Area2D = $DetectionArea

@export var player: CharacterBody2D
@export var speed: float = 100.0

var perseguindo := false

func _physics_process(delta):
	if perseguindo:
		var next_path_position = navigation_agent_2d.get_next_path_position()
		var direction = (next_path_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_timer_timeout():
	if perseguindo:
		navigation_agent_2d.target_position = player.global_position

func _on_DetectionArea_body_entered(body):
	if body == player:
		perseguindo = true
		navigation_agent_2d.target_position = player.global_position

func _on_DetectionArea_body_exited(body):
	if body == player:
		perseguindo = false

# Quando o inimigo encosta no jogador
func _on_Area2D_body_entered(body):
	if body == player:
		matar()

# Função genérica para "matar" o jogador
func matar():
	print("O jogador foi pego!")
	get_tree().reload_current_scene()
