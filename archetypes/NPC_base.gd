@abstract
class_name NPC_base
extends Node2D
var daily_actions:Array = []
var default_actions: Array[String] = ["Eat","Sleep","Rest","Play around","Talk to others","Help"]
var archetype: String
var infected: bool
var completed_tasks = []

func get_daily_tasks(possible_tasks:Array)->void:
	daily_actions.clear()
	completed_tasks.clear()

	var deck = possible_tasks.duplicate()
	deck.shuffle()
	var hand = deck.slice(0,3)
	daily_actions = daily_actions + hand

func complete_tasks(daytime_passed:int)->void:
	completed_tasks.append(daily_actions[daytime_passed])
