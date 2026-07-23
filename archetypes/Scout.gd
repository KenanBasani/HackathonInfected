class_name Scout
extends NPC_base
var times_talked:int = 0
var Scout_actions:Array[String]=["Explore the area","Search for food","Search for water"]
var possible_actions:Array[String] = default_actions + Scout_actions

func _init() -> void:
	infected = false
	archetype = "scout"
	times_talked = 0
