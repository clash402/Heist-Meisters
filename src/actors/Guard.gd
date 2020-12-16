extends "res://src/items/PlayerDetection.gd"

# PROPERTIES
export var min_distance = 10
export var speed = 0.5

onready var timer = $Timer
onready var line = $Line2D

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")
onready var possible_destinations = destinations.get_children()

var velocity: Vector2
var path: PoolVector2Array


# DEFAULTS
func _ready():
	randomize()
	set_path()


func _physics_process(delta):
	navigate()


# SIGNALS
func _on_Timer_timeout():
	set_path()


# CUSTOM
func navigate():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > min_distance:
		move_along_path()
	else:
		update_path()


func move_along_path():
	velocity = (path[0] - position).normalized() * (MAX_SPEED * speed)
	look_at(path[0])
	move_and_slide(velocity)
	if is_on_wall():
		set_path()


func set_path():
	var ran = randi() % (possible_destinations.size() - 1)
	var new_destination = possible_destinations[ran]
	path = navigation.get_simple_path(global_position, new_destination.global_position)
	line.points = path


func update_path():
	if path.size() == 1:
		timer_is_stopped()
	else:
		path.remove(0)


func timer_is_stopped():
	if timer.is_stopped():
		timer.start()
