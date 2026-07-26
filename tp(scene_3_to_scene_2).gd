extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.entry_point = "FromScene3"
		get_tree().change_scene_to_file("res://scene_2.tscn")
