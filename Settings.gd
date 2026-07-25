extends Node
var hovered_npc = false
var hovered_bullets = false
var waiting_for_input_npc = false
var waiting_for_input_bullet=false
var npc_count_value:int = 5
var bullet_count_value:int=3
var digits:int=0
var hover_back = false

@onready var npc_label: Label = $"Start Game/Label"
@onready var bullet_label:Label = $"Settings/Label2"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rebind(label:Label,newname:String)->void:
	label.text=newname

func _unhandled_input(event: InputEvent) -> void:
	if waiting_for_input_npc:
		if event.is_pressed() and not event.is_echo():
			if event.is_action_pressed("Enter"):
				if npc_count_value >2:
					Global_settings.npc_count = npc_count_value
				waiting_for_input_npc=false
				digits=0
				rebind(npc_label,"Number of NPCs : %d" % npc_count_value)
			if (event is InputEventKey) and OS.get_keycode_string(event.keycode).is_valid_int(): 
				npc_count_value = npc_count_value* digits + OS.get_keycode_string(event.keycode).to_int()
				digits = 10
	if waiting_for_input_bullet:
		if event.is_pressed() and not event.is_echo():
			if event.is_action_pressed("Enter"):
				if bullet_count_value>0:
					Global_settings.bullet_count = bullet_count_value
				waiting_for_input_bullet=false
				digits=0
				rebind(bullet_label,"Number of Bullets : %d" % bullet_count_value)
			if (event is InputEventKey) and OS.get_keycode_string(event.keycode).is_valid_int(): 
				bullet_count_value = bullet_count_value* digits + OS.get_keycode_string(event.keycode).to_int()
				digits = 10
	if event.is_action_pressed("left_click"):
		if hovered_npc:
			waiting_for_input_npc = true
		if hovered_bullets:
			waiting_for_input_bullet=true
		if hover_back:
			get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_npc_entered() -> void:
	hovered_npc = true
func _on_npc_exited() -> void:
	hovered_npc=false
	
func _on_bullets_entered() -> void:
	hovered_bullets=true
func _on_bullets_exited() -> void:
	hovered_bullets=false

func back() -> void:
	hover_back = true
func backex() -> void:
	hover_back = false
