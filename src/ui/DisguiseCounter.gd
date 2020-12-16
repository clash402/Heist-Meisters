extends ItemList

# PROPERTIES
const PATH_BOX = "res://assets/gfx/items/box-2.png"


# CUSTOM
func update_disguise_display(n):
	clear()
	for diguise in range(n):
		add_icon_item(load(PATH_BOX), false)
