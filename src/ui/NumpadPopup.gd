extends Popup

# SIGNALS
signal combination_correct

onready var display_label = $Margin/VBox/Display/DisplayLabel
onready var grid = $Margin/VBox/Buttons/Grid
onready var status_light = $Margin/VBox/Buttons/Grid/StatusLight
onready var two_tone_sfx = $SFX/TwoToneSFX
onready var three_tone_sfx = $SFX/ThreeToneSFX
onready var timer = $Timer

const PATH_GREEN_LIGHT = "res://assets/gfx/ui/dots/dot-green.png"
const PATH_RED_LIGHT = "res://assets/gfx/ui/dots/dot-red.png"

var combination = []
var guess = []


# READY
func _ready():
	connect_buttons()
	reset_lock()


# SIGNALS
func _on_Timer_timeout():
	emit_signal("combination_correct")
	reset_lock()


# CUSTOM
func connect_buttons():
	for child in grid.get_children():
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])


func Button_pressed(button_text):
	if button_text == "OK":
		check_guess()
	else:
		enter_number(int(button_text))


func check_guess():
	if guess == combination:
		three_tone_sfx.play()
		status_light.texture = load(PATH_GREEN_LIGHT)
		timer.start()
	else:
		reset_lock()


func enter_number(button_number):
	two_tone_sfx.play()
	guess.append(button_number)
	update_display()


func update_display():
	display_label.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()


func reset_lock():
	status_light.texture = load(PATH_RED_LIGHT)
	display_label.text = ""
	guess.clear()
