extends Node

var is_grid_open: bool = false
var companions_on_screen = 0

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

func StartCompanionSpawnLifeCycle():
	if GameState.companions_on_screen == 3:
		return
	var factory = load("res://scripts/companions.gd").new()
	var random_companion = CompanionsByLevel.forest_companions.pick_random()
	var companionToSpawn = factory.create_companion(random_companion)
	
	var gameplay_node = get_tree().get_first_node_in_group("port")
	print(gameplay_node)
	
	if gameplay_node == null:
		print("Gameplay node not found")
		return	
	
	if companionToSpawn:
		companionToSpawn.spawn_companion(gameplay_node)
		GameState.companions_on_screen + 1
	else:
		print("Failed to create companion")
