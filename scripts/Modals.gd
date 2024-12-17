extends CanvasLayer

@onready var grid_overlay = $GridOverlay
@onready var player: CharacterBody2D
@export var camera: Camera2D

var GridItemScene = preload("res://scenes/GridItem.tscn")

func _on_grid_pressed(type):
	var label = get_node("GridOverlay/Label")
	label.text = type.to_upper()
	populate_grid(type)
	grid_overlay.visible = true
	GameState.is_grid_open = grid_overlay.visible

func populate_grid(type):
	print(type)
	var grid = grid_overlay.get_node("ItemsGrid")
	queue_free_grid_items()
	var items = []
	var default_image_path = ""
	
	match type:
		"pets":
			items = PlayerData.pets
			default_image_path = "res://assets/pets/avatars/petplaceholder128.png"
			print(items)
		"inventory":
			items = PlayerData.inventory
			default_image_path = "res://assets/inventory/inventoryplaceholder128.png"
		"equipment":
			items = PlayerData.equipment
			default_image_path = "res://assets/equipment/equipmentplaceholder128.png"

	for item in items:
		var grid_item = GridItemScene.instantiate()
		var image_node = grid_item.get_node("VBoxContainer/ItemImage")
		var label_node = grid_item.get_node("VBoxContainer/ItemLabel")
		
		var texture = load(item["image"])
		if texture and texture is Texture:
			image_node.texture = texture
		else:
			var default_texture = load(default_image_path)
			if default_texture and default_texture is Texture:
				image_node.texture = default_texture
				print("Assigned default texture for item:", item["text"])
			else:
				print("Error: Default texture not found or invalid.")
				
		label_node.text = item["text"]
		grid.add_child(grid_item)

	print("Grid population completed.")
		
func queue_free_grid_items():
	var grid = grid_overlay.get_node("ItemsGrid")
	for child in grid.get_children():
		child.queue_free()
	print("Existing grid items cleared.")
