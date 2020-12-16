extends Area2D

# PROPERTIES
onready var light_occluder = $Sprite/LightOccluder2D
onready var anim_player = $AnimationPlayer

const PLAYER_COLLISION_LAYER = 1
const NPC_COLLISION_LAYER = 4
const DISGUISE_COLLISION_LAYER = 16

var can_open = false


# DEFAULTS
func _ready():
	light_occluder.visible = true


# SIGNALS
func _on_body_entered(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER or body.collision_layer == DISGUISE_COLLISION_LAYER:
		can_open = true
	else:
		open()


func _on_body_exited(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER or body.collision_layer == DISGUISE_COLLISION_LAYER:
		can_open = false


func _on_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_open:
		open()


# CUSTOM
func open():
	anim_player.play("open-close")
