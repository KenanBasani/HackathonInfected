class_name DialogueBox
extends CanvasLayer

@onready var name_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var text_label: RichTextLabel = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel

var is_displaying: bool = false

func _ready() -> void:
	hide()

func display_text(speaker_name:String, dialogue_text: String) -> void:
	name_label.text = speaker_name
	text_label.text = "[color=white]" + dialogue_text + "[/color]"

	text_label.visible_characters = -1
	show()
	is_displaying = true
	#animates the text showup
	var tween = create_tween()
	var duration = dialogue_text.length() * 0.03 # Adjust typing speed here
	tween.tween_property(text_label, "visible_characters", dialogue_text.length(), duration)
	
func close() -> void:
	hide()
	is_displaying = false
