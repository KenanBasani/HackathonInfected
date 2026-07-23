class_name Hunter
extends NPC_base
var times_talked:int = 0
var Hunter_actions:Array[String] = ["Hunt a deer","Sharpen tools","Search for animals"]
var possible_actions:Array[String] = default_actions + Hunter_actions

func _init() -> void:
	infected = false
	archetype = "hunter"
	times_talked = 0

	
	
