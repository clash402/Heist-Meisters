extends Area2D

# PROPERTIES
const PATH_VICTORY = "res://src/ui/Victory.tscn"


# SIGNALS
func _on_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().change_scene(PATH_VICTORY)
