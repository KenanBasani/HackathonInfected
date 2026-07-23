class_name Scout
extends NPC_base
var times_talked:int = 0
func _init() -> void:
	dialogue = ["hi,scout","hello,scout"]
	infected = false
	archetype = "scout"
	times_talked = 0

func get_lines(is_infected:bool)->String:
	var random_dialogue: String = dialogue.pick_random()
	return random_dialogue
	
