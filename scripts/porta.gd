extends Area2D
@export var next_level : String = ""

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is Player:
		Global.destination_level = get_parent().name 
		get_tree().call_deferred("change_scene_to_file", next_level)

#func change_scene_to_file():
	
