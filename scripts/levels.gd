extends Node2D

@onready var player = $"."


func _ready() -> void:
	if Global.destination_level != "":
		var point = get_node(Global.destination_level)
		if point: 
			Player.global_position = point.global_position
			
