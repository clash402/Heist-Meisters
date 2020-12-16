extends Node2D

# PROPERTIES
signal set_combination

export var combination_length = 3

onready var computer_popup = $CanvasLayer/ComputerPopup
onready var monitor_light = $MonitorLight

var can_click = false
var combination = []


# DEFAULTS
func _ready():
	generate_combination(combination_length)
	set_computer_popup_text()
	emit_signal("set_combination", combination)


# SIGNALS
func _on_body_entered(body):
	can_click = true


func _on_body_exited(body):
	can_click = false
	computer_popup.hide()
	monitor_light.enabled = false


func _on_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		computer_popup.popup_centered()
		monitor_light.enabled = true


# CUSTOM
func generate_combination(length):
	combination = CombinationGenerator.generate_combination(length)


func set_computer_popup_text():
	computer_popup.set_text(combination)
