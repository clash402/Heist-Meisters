extends "res://src/actors/Actor.gd"

# PROPERTIES
onready var flashlight = $Flashlight
onready var Player = get_tree().get_root().find_node("Player", true, false)

const FOV_TOLERANCE = 20
const MAX_DETECTION_RANGE = 640

const WHITE = Color(1, 1, 1)
const RED = Color(1, 0.25, 0.25)


# DEFAULTS
func _process(delta):
	can_see_Player()


# CUSTOM
func can_see_Player():
	if Player_is_in_FOV() and Player_is_in_LOS():
		flashlight.color = RED
		get_tree().call_group("suspicion_meter", "player_is_seen")
	else:
		flashlight.color = WHITE


func Player_is_in_FOV():
	var facing_dir = Vector2(1, 0).rotated(global_rotation)
	var dir_to_Player = (Player.position - global_position).normalized()
	var Player_detected = abs(dir_to_Player.angle_to(facing_dir)) < deg2rad(FOV_TOLERANCE)
	
	if Player_detected:
		return true
	else:
		return false


func Player_is_in_LOS():
	var space = get_world_2d().direct_space_state
	var obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	var distance_to_player = Player.global_position.distance_to(global_position)
	var Player_is_in_range = distance_to_player < MAX_DETECTION_RANGE
	
	if obstacle.has("collider"):
		if obstacle.collider == Player and Player_is_in_range:
			return true
		else:
			return false
