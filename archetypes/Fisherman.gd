class_name Fisherman
extends NPC_base
var times_talked:int = 0
func _init() -> void:
	dialogue = ["hi,fisherman","hello,fisherman"]
	infected = false
	archetype = "fisherman"
	times_talked = 0


func get_lines(is_infected:bool)->String:
	var random_dialogue: String = dialogue.pick_random()
	return random_dialogue	
