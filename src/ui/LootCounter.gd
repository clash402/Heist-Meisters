extends NinePatchRect

# PROPERTIES
onready var item_list = $Margin/VBox/ItemList
const PATH_BRIEFCASE = "res://assets/gfx/items/briefcase.png"

# DEFAULTS
func _ready():
	hide()


# CUSTOM
func collect_loot():
	item_list.add_icon_item(load(PATH_BRIEFCASE), false)
	show()
