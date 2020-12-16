extends "res://src/items/Door.gd"

# PROPERTIES
onready var numpad = $CanvasLayer/NumpadPopup


# SIGNALS
func _on_body_exited(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER or body.collision_layer == DISGUISE_COLLISION_LAYER:
		can_open = false
		numpad.hide()


func _on_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_open:
		numpad.popup_centered()


func _on_Numpad_combination_correct():
	open()
	numpad.hide()


func _on_Computer0_set_combination(numbers):
	numpad.combination = numbers
