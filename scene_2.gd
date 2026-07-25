extends Node2D

func _ready() -> void:
	if Global.entry_point == "FromScene3":
		$Player.global_position = $FromScene3.global_position

	Global.entry_point = ""
