extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var from_scene_2: Marker2D = $FromScene2

func _ready() -> void:
	if Global.arriving_from_scene_2:
		player.global_position = from_scene_2.global_position
		Global.arriving_from_scene_2 = false
