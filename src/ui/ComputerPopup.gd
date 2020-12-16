extends Popup

# PROPERTIES
onready var label = $Margin/Center/Screen/Margin/Label


# CUSTOM
func set_text(combination):
	label.text = (
		"Will you stop forgetting your access code?! \n\nI've set it to "
		+ PoolStringArray(combination).join("")
		+ ". \n\nDon't forget it this time!"
	)
