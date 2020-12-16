extends CanvasLayer

# PROPERTIES
const PATH_LEVEL_1 = "res://src/levels/Level1.tscn"
const PATH_TUTORIAL = "res://src/levels/Tutorial.tscn"


# SIGNALS
func _on_StartButton_pressed():
	get_tree().change_scene(PATH_LEVEL_1)


func _on_TutorialButton_pressed():
	get_tree().change_scene(PATH_TUTORIAL)


func _on_QuitButton_pressed():
	get_tree().quit()
