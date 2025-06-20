extends MarginContainer

@onready var text_label: Label = $label_margin/text_label
@onready var timer: Timer = $Timer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_display_timer := 0.02
var space_display_timer := 0.04
var punctuation_display_timer := 0.06

signal text_display_finished()

func display_text(text_to_display: String):
	text = text_to_display
	text_label.text = text_to_display
	
	await get_tree().process_frame
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await get_tree().process_frame
		await get_tree().process_frame
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	text_label.text = ""
	letter_index = 0 # ← IMPORTANTE!
	display_letter()

func display_letter():
	if letter_index < text.length():
		var current_char = text[letter_index]
		print("Exibindo letra: ", current_char) # ← DEBUG
		text_label.text += current_char
		letter_index += 1
		
		match current_char:
			"!", "?", ",", ".":
				timer.start(punctuation_display_timer)
			" ":
				timer.start(space_display_timer)
			_:
				timer.start(letter_display_timer)
	else:
		print("Texto completo exibido!") # ← DEBUG
		text_display_finished.emit()

func _on_Timer_timeout():
	print("Timer terminou, próxima letra") # ← DEBUG
	display_letter()
