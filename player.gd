extends CharacterBody2D
class_name Player
@export var speed: float = 385.0 # movement speed
var interactables = [];
static var bullets_left:int = 0

#TO read the json file
var file = FileAccess.open("res://Dialogue.json", FileAccess.READ)

# The dialogue lines pulled from the json
var Reporting_lines
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
	if (currentInteraction) and bullets_left:
		bullets_left -=1
		currentInteraction.killNPC()
		#Announce the kill
		var npc_killed_name = ""
		var npc = currentInteraction.get_parent()
		for child in npc.get_children():
			if child is NPC_base:
				npc_killed_name = child.archetype
				child.infected = false
		DialogueBox.make_dialogue_box("Announcer","You have killed the %s." % [npc_killed_name])
		var game_ended = check_if_game_ended()
		await get_tree().create_timer(2.0).timeout
		print(game_ended)
		if game_ended == 2:
			DialogueBox.make_dialogue_box("Announcer","Congratulations, you won! All the infected have been killed")
		if game_ended == 1:
			DialogueBox.make_dialogue_box("Announcer","You lost! The infected will swarm the island!")
	return 

func getInteractionWinner():
	if (interactables.size() != 0):
		return interactables[0]
	return
	

#This function activates when the user presses E
func _unhandled_input(event: InputEvent) -> void:
	#The action "Interact" itself is tied to the letter E
	var currentInteraction = getInteractionWinner()
	if (event.is_action_pressed("interact") or event.is_action_pressed("Action_question") or event.is_action_pressed("Report_question")) and currentInteraction and DayClock.current_time == "night":
		var npc = currentInteraction.get_parent()
		for child in npc.get_children():
			if child is NPC_base: #If any one of the children nodes is an archetype 
				var line:String = get_character_line(child,child.times_talked,event)
				var name2 = child.archetype
				DialogueBox.make_dialogue_box(name2,line)
				child.times_talked +=1
				#Cleanup and increments the number of times talked
				break
	
# Reads the json files and saves everything in the json to global variables, all of the ones below are dictionary data structures
func read_json_lines()->void:
	var raw_text=file.get_as_text()
	var data = JSON.parse_string(raw_text)
	Reporting_lines = data["Reporting_lines"]
	Location_lines = data["Location_lines"]
	Infected_mistakes = data["Infected_mistakes"]
	Introduction_lines = data["Introduction_lines"]
	
func get_character_line(child:NPC_base,times_talked:int,event:InputEvent)->String:
	var line = ""
	if child.times_talked == 0: #If they didnt talk, introduce yourselves
		line= Introduction_lines.get(child.archetype, "Archetype not matching")
		if child.infected and randf()>0.8:
			line = Infected_mistakes.get(child.archetype,"Archetype not matching")
		line = line.replace("name",child.charname)
	if child.times_talked>0 and event.is_action_pressed("Action_question"):
		var action_done = randi_range(0,2)
		line = Location_lines.get(child.recorded_places[action_done],"").pick_random() + "," + child.daily_actions[action_done]
	if child.times_talked>0 and event.is_action_pressed("Report_question"):
		var action_equal = {}
		var action_just_missed_by = {}
		for npc in Manage_NPCs.npc_list:
			if npc != null:
				for child_of_npc in npc.get_children():
					if child_of_npc is NPC_base and child != child_of_npc:
						for i in range(0,child_of_npc.recorded_places.size()-1):
							if child.recorded_places[i] == child_of_npc.recorded_places[i]:
								action_equal[child.recorded_places[i]] = [i,child_of_npc]
							if i<2 and child_of_npc.recorded_places.size()>2 and child.recorded_places.size()>2:
								if child.recorded_places[i+1] == child_of_npc.recorded_places[i]:
									action_just_missed_by[child.recorded_places[i+1]] = [i+1,child_of_npc.recorded_places[i],child_of_npc]
								if child.recorded_places[i] == child_of_npc.recorded_places[i+1]:
									action_just_missed_by[child.recorded_places[i]] = [i,child_of_npc.recorded_places[i+1],child_of_npc]
		var report_action = "with" if action_just_missed_by.is_empty() or randf()>0.5 else "saw"
		if report_action == "with":
			var actions_info = action_equal.values().pick_random()
			line = Reporting_lines.get("with").replace("player1",actions_info[1].charname).replace("action",child.completed_tasks[actions_info[0]])
		if report_action == "saw":
			var actions_info = action_just_missed_by.values().pick_random()
			line = Reporting_lines.get("saw").replace("player1",actions_info[2].charname).replace("place",actions_info[1]).replace("action",child.completed_tasks[actions_info[0]])
		
	
	child.times_talked +=1
	return line
	
	
	
func check_if_game_ended()->int:
	var number_of_infected_left:int = 0
	for npc in Manage_NPCs.npc_list:
		if npc != null:
			for child in npc.get_children():
				if child is NPC_base:
					if child.infected:
						number_of_infected_left = number_of_infected_left + 1
						print(child.archetype)
	if number_of_infected_left==0:
		return 2
	if (bullets_left == 0 and number_of_infected_left>0) or number_of_infected_left>bullets_left:
		return 1
	else:
		return 0
