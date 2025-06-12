extends CanvasLayer

@onready var voltar = $menu_pausa/voltar

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  # Este nó continua funcionando mesmo quando o jogo está pausado
	voltar.process_mode = Node.PROCESS_MODE_ALWAYS  # O botão também


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		visible = true
		get_tree().paused = true
		#voltar.grab_focus()

func _on_voltar_pressed():
	get_tree().paused = false
	visible = false

func _on_sair_pressed(): 
	get_tree().change_scene_to_file("res://cenas/tela_de_titulo.tscn")
