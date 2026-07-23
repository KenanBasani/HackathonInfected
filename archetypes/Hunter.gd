class_name Hunter
extends NPC_base
var times_talked:int = 0
func _init() -> void:
	dialogue = ["hi,hunter","hello,hunter"]
	infected = false
	archetype = "hunter"
	times_talked = 0

func get_lines(is_infected:bool)->String:
	var random_dialogue: String = dialogue.pick_random()
	return random_dialogue
	
	
	
