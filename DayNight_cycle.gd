extends Node
class_name DayClock
@export var day_time = 20.0
@export var night_time = 10.0
static var current_time = ""
@onready var timer: Timer = $Timer
var task_timer_timeouts = 0
var task_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.bullets_left = round((len(Manage_NPCs.npc_list)/4)*3)
	timer.wait_time = day_time
	initialize_task_timer()
	timer.start()

func initialize_task_timer()->void:
	task_timer.one_shot = true
	task_timer.timeout.connect(_on_task_timer_timeout)
	add_child(task_timer)
	task_timer.wait_time = floor(day_time/3)
	task_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var day_or_night = "The day has begun"
	
	if timer.wait_time == night_time: #at the end of the night
		timer.wait_time = day_time
		Manage_NPCs.on_day_start()
		day_or_night = "The day has started"
		current_time = "day"
		task_timer.start()
	elif timer.wait_time == day_time: # at the end of the day
		timer.wait_time = night_time
		day_or_night = "The night has begun"	
		current_time = "night"

	DialogueBox.make_dialogue_box("Announcement",day_or_night)
	if current_time == "day":
		Manage_NPCs.infect_npc()
	timer.start()
	print(timer.wait_time)
	
func _on_task_timer_timeout()->void:
	if task_timer_timeouts>2:
		task_timer_timeouts = 0
		return
	for npc in Manage_NPCs.npc_list:
		if npc == null:
			continue
		for child in npc.get_children():
			if child is NPC_base:
				child.complete_tasks(task_timer_timeouts)
	task_timer_timeouts +=1
	task_timer.start()
