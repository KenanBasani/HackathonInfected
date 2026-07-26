@abstract
class_name NPC_base
extends Node2D
var daily_actions:Array = []
var default_actions: Array[String] = ["Eating","Resting","Playing around","Talking to others","Helping", "Visiting the beach", "Went for a walk in the forest"]
var archetype: String
var infected: bool
var completed_tasks = []
var recorded_places = []

func get_daily_tasks(possible_tasks:Array)->void:
	daily_actions.clear()
	completed_tasks.clear()

	var deck = possible_tasks.duplicate()
	deck.shuffle()
	var hand = deck.slice(0,3)
	daily_actions = daily_actions + hand

func complete_tasks(daytime_passed:int)->void:
	completed_tasks.append(daily_actions[daytime_passed])
	if daily_actions[daytime_passed] in ["Eating","Resting","Playing around","Talking to others","Helping","Cooking food","Reading the cookbook","Testing recipes","Sharpening tools"]:
		recorded_places.append("campfire")
	if daily_actions[daytime_passed] in ["Visiting the beach","Fishing", "Exploring the beach"]:
		recorded_places.append("beach")
	if daily_actions[daytime_passed] in ["Went for a walk in the forest","Exploring the area","Searching for food","Searching for water","Hunting deers","Sharpening tools","Searching for animals"]:
		recorded_places.append("forest")
