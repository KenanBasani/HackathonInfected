extends Area2D

#var scene2Resource = preload("res://scene_2.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#get_tree().change_scene_to_file("res://scene_2.tscn")
		#var scene2 = scene2Resource.instantiate()
		get_tree().call_deferred(
			"change_scene_to_file",
			"res://scene_2.tscn"
		)
		#scene2.position = Vector2(-100, -100)
		#scene2.show();
		#get_tree().current_scene.add_child(scene2)
		#scene2.visible = true
		print(get_parent().name)
		print(get_parent().name)
		#get_parent().queue_free()
