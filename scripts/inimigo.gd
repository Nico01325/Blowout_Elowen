extends CharacterBody2D

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var detection_area = $DetectionArea

@export var Player: Player
@export var Speed: float = 100

var perseguindo := false

func _physics_process(delta):
	if perseguindo:
		var direction = Vector2(Player.global_position.x-self.global_position.x, Player.global_position.y-self.global_position.y).normalized()
		velocity = direction * Speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_timer_timeout():
	if perseguindo:
		navigation_agent_2d.target_position = Player.global_position


func _on_DetectionArea_body_entered(body):
	if body == Player:
		perseguindo = true
		navigation_agent_2d.target_position = Player.global_position

func _on_DetectionArea_body_exited(body):
	if body == Player:
		perseguindo = false
		
		
func _on_Area2D_body_entered(body):
		if body.name == "Player":
			get_tree().reload_current_scene()
# Fiz comendo pão
