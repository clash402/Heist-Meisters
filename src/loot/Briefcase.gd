extends Area2D

# SIGNALS
func _on_body_entered(body):
	body.collect_briefcase()
	queue_free()
