extends CharacterBody2D
signal suicide

func kill_self():
	queue_free()


func _on_interaction_area_killed() -> void:
	suicide.emit(self)
	kill_self()
	pass # Replace with function body.
