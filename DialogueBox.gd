class_name DialogueBox
extends CanvasLayer

@onready var name_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var text_label: RichTextLabel = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
const dialogue_scene: PackedScene = preload("res://DialogueBox.tscn")
var is_displaying: bool = false
static var previous_box:DialogueBox = DialogueBox.new()
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
	queue_free()
	
static func make_dialogue_box(name:String,line:String)->void:
	if is_instance_valid(previous_box):
			previous_box.close()
	var dialogue = dialogue_scene.instantiate() as DialogueBox
	Engine.get_main_loop().current_scene.add_child(dialogue)
	dialogue.display_text(name, line)
	previous_box = dialogue
