extends Node2D

# PROPERTIES
onready var hud = $HUD
onready var tween = $Objectives/Tween
onready var obj_pointer_sfx = $Objectives/ObjPointerSFX


# DEFAULTS
func _ready():
	$HUD/Margin/VBox/HBox1/Instructions.visible = true
	yield(get_tree(), "idle_frame")
	update_pointer_pos(0)


# SIGNALS
func _on_MoveObj_body_entered(body):
	update_pointer_pos(1)


func _on_DoorObj_body_entered(body):
	update_pointer_pos(2)


func _on_NightvisionObj_body_entered(body):
	get_tree().call_group("ui", "to_DARK")
	update_pointer_pos(3)


func _on_BriefcaseObj_body_entered(body):
	update_pointer_pos(4)


# CUSTOM
func update_pointer_pos(obj_num):
	var pointer = $Objectives/ObjPointer
	var place = $Objectives/ObjPositions.get_child(obj_num)
	var obj_msg = $Objectives/ObjMsgs.get_child(obj_num).message
	
	tween.interpolate_property(pointer, "position", pointer.position, place.position, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	obj_pointer_sfx.play()
	hud.update_instructions(obj_msg)
	$HUD/AnimationPlayer.play("msg_change")
