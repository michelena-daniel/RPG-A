extends Node

var is_grid_open: bool = false

# Function to add a companion to the grid and pets list
func add_companion(companion: Companion) -> void:
	var pets = PlayerData.pets
	if companion and not pets.has(companion):
		# Find the first empty row
		var first_empty_index = find_first_empty_row(pets)
		
		if first_empty_index != -1:
			pets[first_empty_index]["image"] = companion.avatar_path
			pets[first_empty_index]["text"] = companion.companionName
			print("Companion added to grid at row ID:", pets[first_empty_index]["id"])
		else:
			print("No empty rows available to add the companion:", companion.companionName)
	else:
		print("Companion is already collected or invalid:", companion.companionName)

# Helper function to find the first empty row
func find_first_empty_row(pets) -> int:
	for index in pets.size():
		if pets[index]["text"] == "Empty":
			return index
	return -1
