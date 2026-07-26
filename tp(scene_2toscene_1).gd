extends Area2D
var scene1Resource = preload("res://Scene1.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.arriving_from_scene_2 = true
		#get_tree().change_scene_to_file("res://main.tscn")

	if body.name == "Player":
		#get_tree().change_scene_to_file("res://scene_2.tscn")
		
		get_tree().call_deferred(
			"change_scene_to_file",
			"res://Scene1.tscn"
		)
		#var scene1 = scene1Resource.instantiate()
		#scene1.position = Vector2(-100, -100)
		#get_tree().current_scene.add_child(scene1)
		#scene1.visible = true
		print(get_parent().name)
		print(get_parent().name)
		#get_parent().queue_free()
