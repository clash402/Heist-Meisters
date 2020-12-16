extends Node

# CUSTOM
func generate_combination(length):
	randomize()
	var combination = []
	for i in range(length):
		combination.append(randi() % 10)
	return combination
