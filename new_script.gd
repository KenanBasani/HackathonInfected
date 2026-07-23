extends Node2D
#TO read the json file
var file = FileAccess.open("res://Dialogue.json", FileAccess.READ)

#To check whether an npc is selected
var hovered_npc: Node = null
var is_mouse_hovering: bool = false

#To create several instances of NPCs
var archetype: NPC_base
var npc_scene: PackedScene = preload("res://NPC.tscn")
var npc_list: Array[NPC_base] = []
var classes: Array = [Hunter,Cook,Fisherman,Scout]

#to opena nd close dialogue boxes
var dialogue_scene: PackedScene = preload("res://DialogueBox.tscn")
var exists_previous:bool = false
var diabox

# The dialogue lines pulled from the json
var Action_lines
var Location_lines
var Infected_mistakes
var Introduction_lines


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Its working!")
	read_json_lines()
	spawn_n_npcs(5)
	#for child in get_children():
		#if child is NPC_base:
		#	archetype = child
		#	break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_n_npcs(count: int) -> void:
	for i in range(count):
		var new_npc = npc_scene.instantiate()
		new_npc.position = Vector2(i * 170 +200, 100) 
		#Creates a new instance of NPC.tscn n times and spaces them out evenly so theyre not one above another
		
		var area = new_npc.get_node("Area2D")
		area.mouse_entered.connect(_on_area_2d_mouse_entered.bind(new_npc))
		area.mouse_exited.connect(_on_area_2d_mouse_exited.bind(new_npc))
		#This makes each npc have its own signal when hovered, necessary
		
		var random_class = classes.pick_random()
		var archetype: NPC_base = random_class.new()
		new_npc.add_child(archetype)
		#Adds an archetype for each npc as a child node
		
		add_child(new_npc)
		npc_list.append(new_npc)
		#adds the npc to the scene

#This function activates when the user presses E
func _unhandled_input(event: InputEvent) -> void:
	#The action "Interact" itself is tied to the letter E
	if event.is_action_pressed("interact") and is_mouse_hovering:
		if exists_previous:
			diabox.close() #Close the last dialog
		for child in hovered_npc.get_children():
			if child is NPC_base: #If any one of the children nodes is an archetype 
				var line:String = get_character_line(child.archetype,child.times_talked)
				diabox = dialogue_scene.instantiate()
				add_child(diabox)
				diabox.display_text(child.archetype,line)
				#Gets the line and displays it through the Dialogue_scene, using Dialoguebox.gd info
				
				exists_previous = true
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
	
func get_character_line(archetype:String,times_talked:int)->String:
	if times_talked == 0: #If they didnt talk, introduce yourselves
		var line= Introduction_lines.get(archetype, "Archetype not matching")
		return line
	if times_talked > 0:
		#Will be added later on as game is developed, for now randomly chooses whether they were somewhere or they did something
		var action_line= Action_lines.get(archetype, "Archetype not matching")
		var location = "campfire" if randf()>0.5 else "living_room"
		var location_line= Location_lines.get(location, "Location not matching")
		var line = action_line if randf()>0.5 else location_line
		return line 
	else:
		return "Times talked below 0?" # should never happen
		

func _on_area_2d_mouse_entered(npc:Node) -> void:
	is_mouse_hovering = true
	hovered_npc = npc 
	# sets the hovered_npc global variable to be the npc youre hovering on, so its data can be used

func _on_area_2d_mouse_exited(npc:Node) -> void:
	is_mouse_hovering = false
	if hovered_npc == npc:
		hovered_npc = null
	# reverses it so theres no way it triggers when not hovering
