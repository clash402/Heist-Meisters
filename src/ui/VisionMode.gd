extends CanvasModulate

# PROPERTIES
onready var to_dark_sfx = $ToDarkSFX
onready var to_light_sfx = $ToLightSFX
onready var timer = $Timer

const DARK = Color("0d0d0d")
const GREEN = Color("37bf62")

var is_cooling_down = false


# DEFAULTS
func _ready():
	visible = true
	color = DARK


# SIGNALS
func _on_Timer_timeout():
	is_cooling_down = false


# CUSTOM
func toggle_vision_mode():
	if not is_cooling_down:
		if color == DARK:
			to_GREEN()
		else:
			to_DARK()
		is_cooling_down = true
		timer.start()


func to_DARK():
	color = DARK
	to_dark_sfx.play()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")


func to_GREEN():
	color = GREEN
	to_light_sfx.play()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")
