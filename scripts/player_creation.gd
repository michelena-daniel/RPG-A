extends Control

# Variables to store player data
var player_name = ""
var player_class = ""
#UI elements
@onready var name_input = $NameContainer/EnterPlayerName/LineEdit
@onready var class_selector = $ClassContainer/SelectPlayerClass/OptionButton

func _ready():
	player_class = class_selector.get_item_text(1)
	
func _process(delta):
	pass

func _on_confirm_pressed():
	player_name = name_input.text.strip_edges()
	player_class = class_selector.get_item_text(class_selector.selected)
	if player_name == "":
		print("Please enter a valid name.")
		return
	if player_name.length() > 14:
		print("Player name can't be longer than 14 characters")
	# Store player data in the singleton
	PlayerData.player_name = player_name
	PlayerData.player_class = player_class
	PlayerData.pets = build_empty_grid()
	PlayerData.inventory = build_empty_grid()
	PlayerData.equipment = build_empty_grid()

	# Change to the new scene
	get_tree().change_scene_to_file("res://scenes/Main_layout.tscn")

func build_empty_grid():
	return [
		{"id": 1, "image": "", "text": "Empty"},
		{"id": 2, "image": "", "text": "Empty"},
		{"id": 3, "image": "", "text": "Empty"},
		{"id": 4, "image": "", "text": "Empty"},
		{"id": 5, "image": "", "text": "Empty"},
		{"id": 6, "image": "", "text": "Empty"},
		{"id": 7, "image": "", "text": "Empty"},
		{"id": 8, "image": "", "text": "Empty"},
		{"id": 9, "image": "", "text": "Empty"},
	]

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainTitle.tscn")
