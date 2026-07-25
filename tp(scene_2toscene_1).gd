extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.arriving_from_scene_2 = true
		get_tree().change_scene_to_file("res://main.tscn")
