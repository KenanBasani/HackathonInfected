class_name Fisherman
extends NPC_base
var times_talked:int = 0 
var Fisherman_actions: Array[String] = ["Fish", "Explore the beach","Collect bait"]
var possible_actions:Array[String] = default_actions + Fisherman_actions
func _init() -> void:
	infected = false
	archetype = "fisherman"
	times_talked = 0
