extends Node
var hover_up:bool = false
var hover_down:bool = false
var hover_left:bool = false
var hover_right:bool = false
var hover_kill:bool = false
var hover_talk:bool = false
var hover_back:bool = false

@onready var up1:Label = $"Up/Label"
@onready var down1:Label = $"Down/Label"
@onready var left1:Label = $"Left/Label"
@onready var right1:Label = $"Right/Label"
@onready var kill1:Label = $"Kill/Label"
@onready var talk1:Label = $"Talk/Label"
var waiting_for_input1:bool = false
var waiting_for_input2:bool = false
var waiting_for_input3:bool = false
var waiting_for_input4:bool = false
var waiting_for_input5:bool = false
var waiting_for_input6:bool = false

# Called when the node enters the scene tree for the first time.

func rebind(label:Label,text:String)->void:
	label.text = text
func _ready() -> void:
	rebind(down1,"Down : %s" % Global_settings.move_down)
	rebind(up1,"Up : %s" % Global_settings.move_up)
	rebind(left1,"Left : %s" % Global_settings.move_left)
	rebind(right1,"Right : %s" % Global_settings.move_right)
	rebind(kill1,"Kill : %s" % Global_settings.kill_npc)
	rebind(talk1,"Talk : %s" % Global_settings.talk_to_npc)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if waiting_for_input1:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			Global_settings.move_down = OS.get_keycode_string(event.keycode)
			rebind(down1,"Down : %s" % Global_settings.move_down)
			waiting_for_input1 = false
	if waiting_for_input2:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			print("got here")
			Global_settings.move_up = OS.get_keycode_string(event.keycode)
			rebind(up1,"Up : %s" % Global_settings.move_up)
			waiting_for_input2 = false
	if waiting_for_input3:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			print("got here2")
			Global_settings.move_left = OS.get_keycode_string(event.keycode)
			rebind(left1,"Left : %s" % Global_settings.move_left)
			waiting_for_input3 = false
	if waiting_for_input4:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			Global_settings.move_right = OS.get_keycode_string(event.keycode)
			rebind(right1,"Right : %s" % Global_settings.move_right)
			waiting_for_input4 = false
	if waiting_for_input5:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			Global_settings.kill_npc = OS.get_keycode_string(event.keycode)
			rebind(kill1,"Kill : %s" % Global_settings.kill_npc)
			waiting_for_input5 = false
	if waiting_for_input6:
		if event.is_pressed() and not event.is_echo() and event is not InputEventMouseButton:
			Global_settings.talk_to_npc = OS.get_keycode_string(event.keycode)
			rebind(talk1,"Talk : %s" % Global_settings.talk_to_npc)
			waiting_for_input6 = false
	if event.is_action_pressed("left_click"):
		if hover_down:
			waiting_for_input1 = true
		if hover_up:
			waiting_for_input2 = true
		if hover_left:
			waiting_for_input3 = true
		if hover_right: 
			waiting_for_input4 = true
		if hover_kill:
			waiting_for_input5 = true
		if hover_talk:
			waiting_for_input6=true
		if hover_back:
			get_tree().change_scene_to_file("res://start_menu.tscn")



func _down() -> void:
	hover_down = true
func _downex() -> void:
	hover_down = false

func up() -> void:
	hover_up = true
	print("entup")
func upex() -> void:
	print("exup")
	hover_up = false

func right() -> void:
	hover_right = true
func rightex() -> void:
	hover_right = false

func kill() -> void:
	hover_kill = true
func killex() -> void:
	hover_kill = false

func talk() -> void:
	hover_talk = true
func talkex() -> void:
	hover_talk = false

func left() -> void:
	hover_left = true
	print("entleft")
func leftex() -> void:
	print("exleft")
	hover_left = false

func back() -> void:
	hover_back = true
func backex() -> void:
	hover_back = false
