extends CharacterBody2D
@export var speed: float = 385.0 # movement speed
var interactables = [];

#TO read the json file
var file = FileAccess.open("res://Dialogue.json", FileAccess.READ)

# The dialogue lines pulled from the json
var Action_lines
var Location_lines
var Infected_mistakes
var Introduction_lines

func _ready()->void:
	read_json_lines()

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
	

#This function activates when the user presses E
func _unhandled_input(event: InputEvent) -> void:
	#The action "Interact" itself is tied to the letter E
	var currentInteraction = getInteractionWinner()
	if event.is_action_pressed("interact") and currentInteraction:
		var npc = currentInteraction.get_parent()
		for child in npc.get_children():
			if child is NPC_base: #If any one of the children nodes is an archetype 
				var line:String = get_character_line(child,child.times_talked)
				var name2 = child.archetype
				DialogueBox.make_dialogue_box(name2,line)
				child.times_talked +=1
				#Cleanup and increments the number of times talked
				break
	
# Reads the json files and saves everything in the json to global variables, all of the ones below are dictionary data structures
func read_json_lines()->void:
	var raw_text=file.get_as_text()
	var data = JSON.parse_string(raw_text)
	Action_lines = data["Action_lines"]
	Location_lines = data["Location_lines"]
	Infected_mistakes = data["Infected_mistakes"]
	Introduction_lines = data["Introduction_lines"]
	
func get_character_line(child:NPC_base,times_talked:int)->String:
	var line = ""
	if times_talked == 0: #If they didnt talk, introduce yourselves
		line= Introduction_lines.get(child.archetype, "Archetype not matching")
	if 3>times_talked and times_talked > 0:
		#Will be added later on as game is developed, for now randomly chooses whether they were somewhere or they did something
		var action_line= Action_lines.get(child.archetype, "Archetype not matching")
		var location = "campfire" if randf()>0.5 else "living_room"
		var location_line= Location_lines.get(location, "Location not matching")
		line = action_line if randf()>0.5 else location_line

	if times_talked>2:
		var linearray = (child.daily_actions)
		line = ""
		for i in linearray:
			line = line + i + "|"
	if child.infected:
		line = line + "I am infected"
	return line

		
