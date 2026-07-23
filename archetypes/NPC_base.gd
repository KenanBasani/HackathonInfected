@abstract
class_name NPC_base
extends Node2D

var dialogue: Array[String]
var archetype: String
var infected: bool

#This function is currenlty useless but might be useful later down the line
@abstract func get_lines(is_infected:bool) -> String
