extends CanvasLayer

# PROPERTIES
onready var instructions_lbl = $Margin/VBox/HBox1/Instructions/Margin/Label


# CUSTOM
func update_instructions(msg):
	instructions_lbl.text = msg
