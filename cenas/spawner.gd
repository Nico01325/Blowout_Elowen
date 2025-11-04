extends Node2D

@export var item_scene: PackedScene
@export var possible_positions: Array[Vector2] = [
	Vector2(200, 200),
	Vector2(400, 200),
	Vector2(600, 300),
	Vector2(250, 400)
]

var itens_coletados := 0

func _ready():
	randomize()
	spawn_random_items(2)

func spawn_random_items(qtd: int):
	var posicoes = possible_positions.duplicate()
	posicoes.shuffle()

	for i in range(qtd):
		if posicoes.is_empty():
			break
		var item = item_scene.instantiate()
		add_child(item)
		item.global_position = posicoes.pop_front()
		item.connect("item_coletado", _on_item_coletado)

func _on_item_coletado():
	itens_coletados += 1
	print("Itens coletados:", itens_coletados)
	if itens_coletados == 2:
		var porta = get_node("../porta")
		if porta and porta.has_method("abrir_porta"):
			porta.abrir_porta()
