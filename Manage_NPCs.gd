extends Node2D
class_name Manage_NPCs

#To create several instances of NPCs
var archetype: NPC_base
var npc_scene: PackedScene = preload("res://NPC.tscn")
static var npc_list: Array[Node] = []
var classes: Array = [Hunter,Cook,Fisherman,Scout]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Its working!")
	spawn_n_npcs(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_n_npcs(count: int) -> void:
	var infected_exists = false
	for i in range(count):
		var new_npc = npc_scene.instantiate()
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
	if DayClock.current_time == "day":
		var npc_list_clone = npc_list.duplicate()
		npc_list_clone.shuffle()
		for npc in npc_list_clone:
			if one_npc_infected or npc == null:
				break
			for child in npc.get_children():
				if child is NPC_base:
					if child.infected:
						continue
					else:
						child.infected=true
						one_npc_infected = true
