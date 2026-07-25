extends Node
class_name DayClock
@export var day_time = 60.0
@export var night_time = 30.0
static var current_time = "day"
@onready var timer: Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.bullets_left = round((len(Manage_NPCs.npc_list)/4)*3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.wait_time = day_time if timer.wait_time == night_time else night_time
	var day_or_night = "The night has begun" if timer.wait_time == day_time else "The day has started"
	current_time = "night" if timer.wait_time == day_time else "day"
	DialogueBox.make_dialogue_box("Announcement",day_or_night)
	if current_time == "day":
		Manage_NPCs.infect_npc()
	
