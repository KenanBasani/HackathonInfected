extends CharacterBody2D

@export var speed: float = 385.0 # movement speed

var interactables = [];

func _physics_process(_delta: float) -> void:
		var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * speed
		move_and_slide()

func _process(_delta):
	# Triggers exactly ONCE when the button is let go
	if Input.is_action_just_pressed("kill"):
		tryToKill()

func addInteractability(interactable: Area2D):
	interactables.append(interactable);
	print(interactables)
	return

func removeInteractability(interactable: Area2D):
	var interactablePosition = interactables.find(interactable)
	interactables.remove_at(interactablePosition)
	print(interactables)
	return

func tryToKill():
	var currentInteraction = getInteractionWinner()
	if (currentInteraction):
		currentInteraction.killNPC()
		print("Kill")
	return 

func getInteractionWinner():
	if (interactables.size() != 0):
		return interactables[0]
	return
