class_name Cook
extends NPC_base
var times_talked:int = 0
var Cook_actions:Array[String] = ["Cook food","Test recipes","Read the cookbook"]
var possible_actions:Array[String] = default_actions + Cook_actions
func _init() -> void:
	infected = false
	archetype = "chef"
	times_talked = 0

	
	
