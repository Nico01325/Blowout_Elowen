extends ScrollContainer

@export var text_node : RichTextLabel
@export_range(1,100000,0.1) var credits_time : float = 1
@export_range(0,100000,0.1) var margin_increment : float = 0

@onready var margin : MarginContainer = $MarginContainer

var started := false

func _process(delta):
	if started:
		return
	
	# Espera até o texto ter um tamanho válido
	if text_node.size.y > 1:
		start_credits()
		started = true

func start_credits():
	var tween = create_tween()
	var text_box_size = text_node.size.y
	print("text_box_size: ", text_box_size)

	var window_size = DisplayServer.window_get_size().y
	margin.add_theme_constant_override("margin_top", window_size + margin_increment)
	margin.add_theme_constant_override("margin_bottom", window_size + margin_increment)

	var scroll_amount = ceil(text_box_size * 3/4 + window_size * 2 + margin_increment)

	tween.tween_property(
		self,
		"scroll_vertical",
		scroll_amount,
		credits_time
	)

	tween.play()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://cenas/tela_de_titulo.tscn")
