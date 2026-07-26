extends Node2D
class_name Manage_NPCs

#To create several instances of NPCs
var archetype: NPC_base
var npc_scene: PackedScene = preload("res://NPC.tscn")
static var npc_list: Array[Node] = []
var classes: Array = [Hunter,Cook,Fisherman,Scout]
static var location_of_last_infection



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Its working!")
	spawn_n_npcs(Global_settings.npc_count)
	rebind_action("move_left",Global_settings.move_left)
	rebind_action("move_right",Global_settings.move_right)
	rebind_action("move_up",Global_settings.move_up)
	rebind_action("move_down",Global_settings.move_down)
	rebind_action("kill",Global_settings.kill_npc)
	rebind_action("interact",Global_settings.talk_to_npc)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func killNPC(npc: Node): 
	npc_list.remove_at(npc_list.find(npc))
	pass

func spawn_n_npcs(count: int) -> void:
	var infected_exists = false
	for i in range(count):
		var new_npc = npc_scene.instantiate()
		new_npc.suicide.connect(Callable(self, "killNPC"))
		new_npc.position = Vector2(i * 250 +200, 100) 
		#Creates a new instance of NPC.tscn n times and spaces them out evenly so theyre not one above another
		
		var random_class = classes.pick_random()
		var archetype: NPC_base = random_class.new()
		new_npc.add_child(archetype)
		#Adds an archetype for each npc as a child node
		
		for child in new_npc.get_children():
			if child is NPC_base:
				if randf()>0.8 and not infected_exists:
					child.infected = true
					infected_exists=true
				if i == count-1 and not infected_exists:
					child.infected = true

		add_child(new_npc)
		npc_list.append(new_npc)
		#adds the npc to the scene
	on_day_start()



static func on_day_start()->void:
	for npc in npc_list:
		for child in npc.get_children():
			if child is NPC_base:
				child.get_daily_tasks(child.possible_actions)

static func infect_npc()->void:
	var one_npc_infected = false
	var possible_to_infect_npcs = []
	
	if DayClock.current_time == "day":
		var npc_list_clone = npc_list.duplicate()
		npc_list_clone.shuffle()
		for npc in npc_list:
			if one_npc_infected or npc == null:
				continue
			for child in npc.get_children():
				if child is NPC_base and child.infected:
					for second_npc in npc_list_clone:
						if second_npc != null:
							for childs in second_npc.get_children():
								if childs is NPC_base:
									var already_in_list:bool = false
									for location in childs.recorded_places:
										if location in child.recorded_places and not already_in_list:
											possible_to_infect_npcs.append([second_npc,location])
											already_in_list = true
		for npc in possible_to_infect_npcs:
			for child in npc[0].get_children():
				if child is NPC_base:
					if not child.infected:
						child.infected = true
						location_of_last_infection = npc[1]
						return
					
func rebind_action(action_name: StringName, new_key: String) -> void:
	InputMap.action_erase_events(action_name)
	var new_event := InputEventKey.new()
	new_event.physical_keycode = (OS.find_keycode_from_string(new_key))
	
	InputMap.action_add_event(action_name, new_event)


func _on_player_kill_npc() -> void:
	
	pass # Replace with function body.
