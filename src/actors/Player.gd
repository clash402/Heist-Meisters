extends "res://src/actors/Actor.gd"

# PROPERTIES
export var disguise_slowdown = 0.25
export var disguise_duration = 5
export var number_of_disguises = 3

onready var sprite = $Sprite
onready var light_occluder = $LightOccluder
onready var light = $Light2D
onready var timer = $Timer

const PATH_PLAYER_SPRITE = "res://assets/gfx/npcs/hitman-stand.png"
const PATH_BOX_SPRITE = "res://assets/gfx/items/box-2.png"
const PATH_HUMAN_OCCLUDER = "res://assets/gfx/occluders/human-occluder.tres"
const PATH_BOX_OCCLUDER = "res://assets/gfx/occluders/box-occluder.tres"
const PATH_PLAYER_LIGHT = "res://assets/gfx/npcs/hitman-stand.png"
const PATH_BOX_LIGHT = "res://assets/gfx/items/box.png"

var velocity = Vector2()
var velocity_multiplier = 1
var is_disguised = false


# DEFAULTS
func _ready():
	timer.wait_time = disguise_duration
	get_tree().call_group("disguise_display", "update_disguise_display", number_of_disguises)
	reveal()


func _physics_process(delta):
	move()


# EVENTS
func _input(event):
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("ui", "toggle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


# SIGNALS
func _on_Timer_timeout():
	reveal()


# CUSTOM
func move():
	look_at(get_global_mouse_position())
	walk()
	move_and_slide(velocity * velocity_multiplier)


func walk():
	walk_up_down()
	walk_left_right()


func walk_up_down():
	var up_is_pressed = Input.is_action_pressed("move_up")
	var down_is_pressed = Input.is_action_pressed("move_down")
	
	if up_is_pressed and not down_is_pressed:
		velocity.y = clamp(velocity.y - SPEED, -MAX_SPEED, MIN_SPEED)
	elif down_is_pressed and not up_is_pressed:
		velocity.y = clamp(velocity.y + SPEED, MIN_SPEED, MAX_SPEED)
	else:
		velocity.y = lerp(velocity.y, MIN_SPEED, FRICTION)


func walk_left_right():
	var left_is_pressed = Input.is_action_pressed("move_left")
	var right_is_pressed = Input.is_action_pressed("move_right")
	
	if left_is_pressed and not right_is_pressed:
		velocity.x = clamp(velocity.x - SPEED, -MAX_SPEED, MIN_SPEED)
	elif right_is_pressed and not left_is_pressed:
		velocity.x = clamp(velocity.x + SPEED, MIN_SPEED, MAX_SPEED)
	else:
		velocity.x = lerp(velocity.x, MIN_SPEED, FRICTION)


func toggle_disguise():
	if is_disguised:
		reveal()
	elif number_of_disguises > 0:
		disguise()


func reveal():
	sprite.texture = load(PATH_PLAYER_SPRITE)
	light.texture = load(PATH_PLAYER_LIGHT)
	light_occluder.occluder = load(PATH_HUMAN_OCCLUDER)
	velocity_multiplier = 1
	collision_layer = 1
	is_disguised = false


func disguise():
	sprite.texture = load(PATH_BOX_SPRITE)
	light.texture = load(PATH_BOX_LIGHT)
	light_occluder.occluder = load(PATH_BOX_OCCLUDER)
	velocity_multiplier = disguise_slowdown
	collision_layer = 16
	is_disguised = true
	
	number_of_disguises -= 1
	get_tree().call_group("disguise_display", "update_disguise_display", number_of_disguises)
	timer.start()


func collect_briefcase():
	var loot = Node.new()
	loot.set_name("Briefcase")
	add_child(loot)
	get_tree().call_group("loot", "collect_loot")
