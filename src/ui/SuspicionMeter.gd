extends TextureProgress

# PROPERTIES
export var step_multiplier = 3


# DEFAULTS
func _ready():
	value = 0


func _process(delta):
	value -= step


# CUSTOM
func player_is_seen():
	value += step * step_multiplier
	if value == max_value:
		end_game()


func end_game():
	get_tree().quit()
