extends Node
var hovering_start:bool=false
var hovering_settings:bool=false
var hovering_controls:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event:InputEvent)->void:
	if event.is_action_pressed("left_click"):
		if hovering_start:
			get_tree().change_scene_to_file("res://main.tscn")
		if hovering_settings:
			get_tree().change_scene_to_file("res://settings.tscn")
		if hovering_controls:
			get_tree().change_scene_to_file("res://controls.tscn")




func _on_start_entered() -> void:
	hovering_start = true
func _on_start_exited() -> void:
	hovering_start=false

func on_settings_entered() -> void:
	hovering_settings=true
func _on_settings_exited() -> void:
	hovering_settings=false

func on_control_entered() -> void:
	hovering_controls=true
func _on_control_exited() -> void:
	hovering_controls=false
