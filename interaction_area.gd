extends Area2D

signal killed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func killNPC():
	killed.emit()
	return
	
func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.addInteractability(self)
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		body.removeInteractability(self)
	pass # Replace with function body.
