extends CharacterBody2D

func kill_self():
	queue_free()


func _on_interaction_area_killed() -> void:
	kill_self()
	pass # Replace with function body.
