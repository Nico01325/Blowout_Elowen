extends CharacterBody2D
class_name Player

var speed := 400

const LIMITES = {
	"esquerda": -645,
	"direita": 780,
	"cima": -490,
	"baixo": 710
}

var ultima_direcao := Vector2.DOWN
@onready var anim := $anim

func _ready() -> void:
	pass

func _physics_process(delta):
	var input := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	# Movimento
	velocity = input * speed

	# Atualiza última direção se estiver se movendo
	if input != Vector2.ZERO:
		ultima_direcao = input

	# Atualiza animação
	update_animation(input)

	# Limita posição
	limitar_posicao()

	move_and_slide()


func update_animation(input: Vector2):
	if input == Vector2.ZERO:
		anim.play("idle")
	else:
		var nome_animacao := definir_animacao(input)
		anim.play(nome_animacao)


func definir_animacao(dir: Vector2) -> String:
	# Diagonais
	if dir.x < 0 and dir.y < 0:
		return "left_up"
	elif dir.x > 0 and dir.y < 0:
		return "right_up"
	elif dir.x < 0 and dir.y > 0:
		return "left_down"
	elif dir.x > 0 and dir.y > 0:
		return "right_down"

	# Horizontais
	elif dir.x != 0:
		anim.flip_h = dir.x > 0
		return "walk"

	# Verticais
	elif dir.y < 0:
		return "up"
	elif dir.y > 0:
		return "down"

	return "idle"


func limitar_posicao():
	position.x = clamp(position.x, LIMITES.esquerda, LIMITES.direita)
	position.y = clamp(position.y, LIMITES.cima, LIMITES.baixo)


func morte():
	get_tree().change_scene_to_file("res://gameover.tscn")
