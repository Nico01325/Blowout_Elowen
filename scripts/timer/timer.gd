extends Control

@onready var timer: Timer = $Timer
@onready var time_label: Label = $TimeLabel


@export var tempo_total: int = 60
var tempo_restante: int = 0

func _ready():
	timer.timeout.connect(_on_timer_timeout)  # ← Conexão explícita do sinal
	iniciar_timer()

func iniciar_timer():
	tempo_restante = tempo_total
	atualizar_label()
	timer.start()

func _on_timer_timeout():
	tempo_restante -= 1
	atualizar_label()
	if tempo_restante <= 0:
		timer.stop()
		on_timer_finish()
		
func atualizar_label():
	var minutos = tempo_restante / 60 
	var segundos = tempo_restante % 60
	time_label.text = "%02d:%02d" % [minutos, segundos]

func on_timer_finish():
	Global.tempo_acabado += 1
	print("Tempo esgotado!")
